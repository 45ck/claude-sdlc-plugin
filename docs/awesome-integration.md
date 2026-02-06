# Awesome Repos Integration

## Context

We want the Claude SDLC Plugin to leverage curated `awesome-*` lists during planning and design, without requiring ad hoc web searching or manual link collecting.

Source notes (local):
- `/home/calvin/Downloads/Enhancing Claude SDLC Plugin_ Awesome Repositories and Agent Teams Integration.docx`

## Decision

Use a **local cache** of curated awesome repositories as an index layer:

- Seed list: `references/awesome/seeds.tsv`
- Local clones: `references/awesome/repos/` (gitignored)
- Sync/update: `scripts/awesome/sync.sh`
- Expose to users/agents via `/sdlc:refs`

Rationale:
- Local search is fast and deterministic.
- No need to embed a brittle static index.
- Keeps the door open for a later “catalog” database without changing the data source.

## Implementation Notes

- The plugin repo includes the seeds + sync tooling for plugin development.
- `/sdlc:init` scaffolding templates can optionally create the same `references/awesome/` structure inside generated projects, so references remain available under the project directory.
- `scripts/awesome/catalog.py` can build a queryable SQLite catalog on top of the local cache (`references/awesome/catalog.sqlite`).

## Next Step (Optional)

Build a small catalog layer on top of the cache:

- Parse READMEs into a small queryable dataset (SQLite or JSON)
- Enrich with GitHub metadata (stars, last push, license) when a token is available
- Add a “compare” view to the planning hub
