#!/usr/bin/env bash
set -euo pipefail

# Sync curated "awesome-*" reference repos locally so Claude agents can search them offline.
#
# Sources are defined in: references/awesome/seeds.tsv
# Clones are stored in:  references/awesome/repos/ (gitignored)

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"

SEEDS_FILE="${PLUGIN_ROOT}/references/awesome/seeds.tsv"
DEST_ROOT="${PLUGIN_ROOT}/references/awesome/repos"
export PLUGIN_ROOT

# Avoid interactive prompts (e.g. if GitHub auth is misconfigured).
export GIT_TERMINAL_PROMPT=0

if ! command -v git >/dev/null 2>&1; then
  echo "ERROR: git not found in PATH" >&2
  exit 1
fi

mkdir -p "${DEST_ROOT}"

echo "Syncing awesome reference repos..."
echo "  Seeds: ${SEEDS_FILE}"
echo "  Dest:  ${DEST_ROOT}"
echo

if [[ ! -f "${SEEDS_FILE}" ]]; then
  echo "ERROR: seeds file not found: ${SEEDS_FILE}" >&2
  exit 1
fi

synced=0
skipped=0

while IFS=$'\t' read -r slug url tags; do
  # Skip comments / blanks.
  [[ -z "${slug}" ]] && continue
  [[ "${slug}" =~ ^# ]] && continue

  if [[ -z "${url}" ]]; then
    echo "WARN: missing url for ${slug}; skipping" >&2
    skipped=$((skipped + 1))
    continue
  fi

  owner="${slug%%/*}"
  repo="${slug##*/}"
  dir="${DEST_ROOT}/${owner}__${repo}"

  if [[ ! -d "${dir}/.git" ]]; then
    echo "[clone] ${slug}"
    git clone --quiet --depth 1 "${url}" "${dir}" >/dev/null
  else
    echo "[update] ${slug}"
    git -C "${dir}" remote set-url origin "${url}" >/dev/null 2>&1 || true

    # Keep it shallow and deterministic: fast-forward to latest remote HEAD.
    git -C "${dir}" fetch --quiet --depth 1 origin HEAD >/dev/null
    git -C "${dir}" reset --hard FETCH_HEAD >/dev/null
    git -C "${dir}" clean -fdx >/dev/null
  fi

  # Store tags locally (useful for tooling / greps later).
  printf "%s\n" "${tags:-}" >"${dir}/.codex-tags"

  synced=$((synced + 1))
done <"${SEEDS_FILE}"

LOCK_FILE="${PLUGIN_ROOT}/references/awesome/LOCK.json"
python3 - <<'PY'
import json
import os
import subprocess
import time
from pathlib import Path

plugin_root = Path(os.environ["PLUGIN_ROOT"])
seeds = plugin_root / "references" / "awesome" / "seeds.tsv"
repos_root = plugin_root / "references" / "awesome" / "repos"
lock_file = plugin_root / "references" / "awesome" / "LOCK.json"

entries = []
now = time.strftime("%Y-%m-%dT%H:%M:%S%z")

def git(*args: str, cwd: Path) -> str:
    return subprocess.check_output(["git", "-C", str(cwd), *args], text=True).strip()

for line in seeds.read_text(encoding="utf-8").splitlines():
    if not line or line.startswith("#"):
        continue
    parts = line.split("\t")
    if len(parts) < 2:
        continue
    slug, url = parts[0].strip(), parts[1].strip()
    tags = parts[2].strip() if len(parts) >= 3 else ""
    owner, repo = slug.split("/", 1) if "/" in slug else (slug, slug)
    repo_dir = repos_root / f"{owner}__{repo}"
    if not (repo_dir / ".git").exists():
        entries.append({"slug": slug, "url": url, "tags": tags, "dir": str(repo_dir), "missing": True})
        continue
    head = git("rev-parse", "HEAD", cwd=repo_dir)
    entries.append(
        {
            "slug": slug,
            "url": url,
            "tags": tags,
            "dir": str(repo_dir.relative_to(plugin_root)),
            "head": head,
            "syncedAt": now,
        }
    )

payload = {"generatedAt": now, "count": len(entries), "entries": entries}
lock_file.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8")
print(f"Wrote {lock_file}")
PY

echo
echo "Done."
echo "  Synced:  ${synced}"
echo "  Skipped: ${skipped}"
echo
echo "Try:"
echo "  rg -n \"observability\" \"${DEST_ROOT}\""
echo "  cat \"${LOCK_FILE}\""
