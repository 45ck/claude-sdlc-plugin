#!/usr/bin/env python3
"""
Build/search a lightweight catalog from local "awesome-*" reference repos.

This is intentionally heuristic: awesome lists are formatted similarly but not identically.
We extract common list-item link patterns from Markdown and index them in SQLite (FTS5).
"""

from __future__ import annotations

import argparse
import re
import sqlite3
import sys
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import urlparse
from typing import Iterator


REPO_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_REPOS_DIR = REPO_ROOT / "references" / "awesome" / "repos"
DEFAULT_DB_PATH = REPO_ROOT / "references" / "awesome" / "catalog.sqlite"

# Keep results useful by default: do not exclude, but penalize low-signal link types.
DEFAULT_DOMAIN_PENALTY = {
    "twitter.com",
    "x.com",
    "t.co",
    "youtube.com",
    "youtu.be",
    "slack.com",
    "medium.com",
    "dev.to",
}


@dataclass(frozen=True)
class Item:
    source_slug: str
    source_file: str
    section: str
    name: str
    url: str
    description: str


_HEADING_RE = re.compile(r"^(#{1,6})\s+(.+?)\s*$")
_BULLET_LINK_RE = re.compile(
    r"""^\s*[-*+]\s+            # bullet
         \[([^\]]{1,200})\]     # [name]
         \((https?://[^)]+)\)   # (url)
         (?:\s*[-–—:]\s*(.*))?  # - desc (optional)
         \s*$""",
    re.VERBOSE,
)


def iter_markdown_files(repos_dir: Path) -> Iterator[Path]:
    # README/readme are the common entry points. Keep it cheap: only index those.
    if not repos_dir.exists():
        return
    for repo_dir in sorted(p for p in repos_dir.iterdir() if p.is_dir()):
        for name in ("README.md", "readme.md", "Readme.md"):
            p = repo_dir / name
            if p.exists():
                yield p


def slug_from_repo_dir(repo_dir: Path) -> str:
    # Our sync script uses owner__repo directory names.
    parts = repo_dir.name.split("__", 1)
    if len(parts) == 2:
        return f"{parts[0]}/{parts[1]}"
    return repo_dir.name


def iter_items_from_markdown(source_slug: str, md_path: Path) -> Iterator[Item]:
    section = ""
    try:
        text = md_path.read_text(encoding="utf-8", errors="replace").splitlines()
    except OSError:
        return

    for line in text:
        m = _HEADING_RE.match(line)
        if m:
            # Drop trailing # decorations and shrink whitespace.
            raw = re.sub(r"\s+#\s*$", "", m.group(2)).strip()
            section = re.sub(r"\s+", " ", raw)
            continue

        m = _BULLET_LINK_RE.match(line)
        if not m:
            continue

        name = re.sub(r"\s+", " ", m.group(1).strip())
        url = m.group(2).strip()
        desc = (m.group(3) or "").strip()

        # Skip internal anchors.
        if url.startswith("http") is False:
            continue

        yield Item(
            source_slug=source_slug,
            source_file=str(md_path.relative_to(REPO_ROOT)),
            section=section,
            name=name,
            url=url,
            description=desc,
        )


def connect(db_path: Path) -> sqlite3.Connection:
    db_path.parent.mkdir(parents=True, exist_ok=True)
    con = sqlite3.connect(str(db_path))
    con.row_factory = sqlite3.Row
    return con


def _table_exists(con: sqlite3.Connection, name: str) -> bool:
    row = con.execute(
        "SELECT 1 FROM sqlite_master WHERE type IN ('table','view') AND name = ? LIMIT 1;",
        (name,),
    ).fetchone()
    return row is not None


def init_db(con: sqlite3.Connection) -> None:
    # Always create the base table. FTS is best-effort because some SQLite builds
    # may not include FTS5.
    con.executescript(
        """
        PRAGMA journal_mode=WAL;
        PRAGMA synchronous=NORMAL;

        CREATE TABLE IF NOT EXISTS items (
          id INTEGER PRIMARY KEY,
          source_slug TEXT NOT NULL,
          source_file TEXT NOT NULL,
          section TEXT NOT NULL,
          name TEXT NOT NULL,
          url TEXT NOT NULL,
          description TEXT NOT NULL
        );
        """
    )

    if _table_exists(con, "items_fts"):
        con.commit()
        return

    try:
        con.executescript(
            """
            CREATE VIRTUAL TABLE IF NOT EXISTS items_fts
            USING fts5(
              name,
              description,
              section,
              source_slug UNINDEXED,
              url UNINDEXED,
              content='items',
              content_rowid='id'
            );

            CREATE TRIGGER IF NOT EXISTS items_ai AFTER INSERT ON items BEGIN
              INSERT INTO items_fts(rowid, name, description, section, source_slug, url)
              VALUES (new.id, new.name, new.description, new.section, new.source_slug, new.url);
            END;

            CREATE TRIGGER IF NOT EXISTS items_ad AFTER DELETE ON items BEGIN
              INSERT INTO items_fts(items_fts, rowid, name, description, section, source_slug, url)
              VALUES ('delete', old.id, old.name, old.description, old.section, old.source_slug, old.url);
            END;

            CREATE TRIGGER IF NOT EXISTS items_au AFTER UPDATE ON items BEGIN
              INSERT INTO items_fts(items_fts, rowid, name, description, section, source_slug, url)
              VALUES ('delete', old.id, old.name, old.description, old.section, old.source_slug, old.url);
              INSERT INTO items_fts(rowid, name, description, section, source_slug, url)
              VALUES (new.id, new.name, new.description, new.section, new.source_slug, new.url);
            END;
            """
        )
    except sqlite3.OperationalError:
        # No FTS5 available. We'll fall back to LIKE search.
        pass

    con.commit()


def rebuild(con: sqlite3.Connection, repos_dir: Path) -> int:
    init_db(con)
    con.execute("DELETE FROM items;")
    if _table_exists(con, "items_fts"):
        con.execute("DELETE FROM items_fts;")

    total = 0
    for md_path in iter_markdown_files(repos_dir):
        source_slug = slug_from_repo_dir(md_path.parent)
        for item in iter_items_from_markdown(source_slug, md_path):
            con.execute(
                """
                INSERT INTO items (source_slug, source_file, section, name, url, description)
                VALUES (?, ?, ?, ?, ?, ?)
                """,
                (
                    item.source_slug,
                    item.source_file,
                    item.section,
                    item.name,
                    item.url,
                    item.description,
                ),
            )
            total += 1
    con.commit()
    return total


def search(con: sqlite3.Connection, query: str, limit: int) -> list[sqlite3.Row]:
    init_db(con)
    if _table_exists(con, "items_fts"):
        # Basic FTS query. Users can pass quoted strings for phrase match.
        return list(
            con.execute(
                """
                SELECT
                  i.source_slug,
                  i.section,
                  i.name,
                  i.url,
                  i.description,
                  bm25(items_fts, 5.0, 2.0, 1.0) AS score
                FROM items_fts
                JOIN items i ON i.id = items_fts.rowid
                WHERE items_fts MATCH ?
                ORDER BY score
                LIMIT ?;
                """,
                (query, limit),
            )
        )

    # Fallback when FTS5 isn't available.
    q = f"%{query.strip().strip('\"')}%"
    return list(
        con.execute(
            """
            SELECT
              source_slug,
              section,
              name,
              url,
              description,
              0.0 AS score
            FROM items
            WHERE name LIKE ? OR description LIKE ? OR section LIKE ? OR source_slug LIKE ?
            LIMIT ?;
            """,
            (q, q, q, q, limit),
        )
    )


def _domain(url: str) -> str:
    try:
        host = urlparse(url).netloc.lower()
    except Exception:
        return ""
    if host.startswith("www."):
        host = host[4:]
    return host


def _filter_and_rank(
    rows: list[sqlite3.Row],
    *,
    limit: int,
    allow_domains: set[str],
    deny_domains: set[str],
    apply_penalty: bool,
    exclude_penalty_domains: bool,
) -> list[sqlite3.Row]:
    def matches(host: str, domain: str) -> bool:
        # Treat "slack.com" as matching "cloud-native.slack.com".
        return host == domain or host.endswith("." + domain)

    def any_match(host: str, domains: set[str]) -> bool:
        return any(matches(host, d) for d in domains)

    def ok(host: str) -> bool:
        if allow_domains and not any_match(host, allow_domains):
            return False
        if deny_domains and any_match(host, deny_domains):
            return False
        if exclude_penalty_domains and any_match(host, DEFAULT_DOMAIN_PENALTY):
            return False
        return True

    ranked: list[tuple[float, sqlite3.Row]] = []
    for r in rows:
        host = _domain(r["url"] or "")
        if not ok(host):
            continue
        base = float(r["score"] or 0.0)
        penalty = 0.0
        if apply_penalty and any_match(host, DEFAULT_DOMAIN_PENALTY):
            penalty = 10.0
        ranked.append((base + penalty, r))

    ranked.sort(key=lambda t: t[0])
    return [r for _, r in ranked[:limit]]


def cmd_build(args: argparse.Namespace) -> int:
    repos_dir = Path(args.repos_dir).resolve()
    db_path = Path(args.db).resolve()
    if not repos_dir.exists():
        print(f"ERROR: repos dir not found: {repos_dir}", file=sys.stderr)
        print("Hint: run ./scripts/awesome/sync.sh first.", file=sys.stderr)
        return 2

    con = connect(db_path)
    try:
        count = rebuild(con, repos_dir)
    finally:
        con.close()

    print(f"Built catalog: {db_path}")
    print(f"Items indexed: {count}")
    return 0


def cmd_search(args: argparse.Namespace) -> int:
    db_path = Path(args.db).resolve()
    if not db_path.exists():
        print(f"ERROR: catalog DB not found: {db_path}", file=sys.stderr)
        print("Hint: run: scripts/awesome/catalog.py build", file=sys.stderr)
        return 2

    con = connect(db_path)
    try:
        # Fetch extra, then post-process for domain penalty/filtering.
        raw = search(con, args.query, args.limit * 10)
        rows = _filter_and_rank(
            raw,
            limit=args.limit,
            allow_domains=set(args.allow_domain or []),
            deny_domains=set(args.deny_domain or []),
            apply_penalty=not args.no_domain_penalty,
            exclude_penalty_domains=args.no_social,
        )
    finally:
        con.close()

    for r in rows:
        desc = r["description"] or ""
        sec = r["section"] or ""
        sec_part = f" ({sec})" if sec else ""
        print(f"- {r['name']}{sec_part} [{r['source_slug']}]")
        if desc:
            print(f"  {desc}")
        print(f"  {r['url']}")
    return 0


def main(argv: list[str]) -> int:
    p = argparse.ArgumentParser(prog="catalog.py")
    sub = p.add_subparsers(dest="cmd", required=True)

    b = sub.add_parser("build", help="Build/rebuild the catalog SQLite DB")
    b.add_argument("--repos-dir", default=str(DEFAULT_REPOS_DIR))
    b.add_argument("--db", default=str(DEFAULT_DB_PATH))
    b.set_defaults(func=cmd_build)

    s = sub.add_parser("search", help="Search the catalog (SQLite FTS)")
    s.add_argument("query")
    s.add_argument("--db", default=str(DEFAULT_DB_PATH))
    s.add_argument("--limit", type=int, default=20)
    s.add_argument("--allow-domain", action="append", help="Only include results from this domain (repeatable)")
    s.add_argument("--deny-domain", action="append", help="Exclude results from this domain (repeatable)")
    s.add_argument("--no-domain-penalty", action="store_true", help="Do not penalize social/blog domains in ranking")
    s.add_argument("--no-social", action="store_true", help="Exclude common social/blog domains entirely")
    s.set_defaults(func=cmd_search)

    args = p.parse_args(argv)
    return int(args.func(args))


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
