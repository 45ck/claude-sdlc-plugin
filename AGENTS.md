# Agent Teams Guide (Repo)

This repository is a Claude Code plugin. Most "logic" is prompt + workflow definitions in:

- `skills/*/SKILL.md`
- `agents/*.md`
- `hooks/hooks.json`

## Local References (Awesome Lists)

This repo includes a curated local cache of `awesome-*` references:

- Seeds: `references/awesome/seeds.tsv`
- Sync: `scripts/awesome/sync.sh`
- Catalog (optional): `scripts/awesome/catalog.py` -> `references/awesome/catalog.sqlite`

When making tech/tool recommendations, prefer local references first:

```bash
rg -n "keyword" references/awesome/repos
./scripts/awesome/catalog.py search "keyword"
```

## Suggested Team Topology

When doing feature work, run these in parallel where possible and then synthesize:

- `domain-analyst`: requirements, acceptance criteria, RTM updates
- `solution-architect`: architecture, OpenAPI, ADRs
- `security-engineer`: threat model + security test plan
- `quality-engineer`: quality gates, test strategy, refactoring/tech debt

## /sdlc:plan Team Mode

`/sdlc:plan` can run in Solo mode or Team mode (parallel subagents + synthesis). Prefer Team mode for non-trivial projects where architecture/security/quality work can proceed in parallel once scenarios/use cases are confirmed.

## Working Agreements

- Prefer small, reviewable diffs.
- Update `CHANGELOG.md` for user-facing changes.
- Keep generated-project templates under `skills/init/templates/` consistent with repo behavior.
- Avoid web browsing unless necessary; use local references for deterministic decisions.
