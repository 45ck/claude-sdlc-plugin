# Awesome References (Local)

This folder is a local cache of curated `awesome-*` GitHub repositories, intended to be searchable by Claude SDLC Plugin agents during planning/design.

## Layout

- `seeds.tsv`: the curated seed list (what gets synced)
- `repos/`: local clones (ignored by git)

## Sync / Update

Run:

```bash
./scripts/awesome/sync.sh
```

Then search locally:

```bash
rg -n "observability" references/awesome/repos
```

Reproducibility:
- `./scripts/awesome/sync.sh` also writes `references/awesome/LOCK.json` (commit SHAs per repo).

## Build A Queryable Catalog (Optional)

If you want faster search and a stable dataset to build tooling on top of:

```bash
./scripts/awesome/catalog.py build
./scripts/awesome/catalog.py search "feature flags"
```
