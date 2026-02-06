# Roadmap (WIP)

## Near Term

- Awesome references:
  - Local cache + sync script (`references/awesome/`, `scripts/awesome/sync.sh`)
  - `/sdlc:refs` skill to expose the workflow
  - Agent + planning guidance to consult local references first
- `/sdlc:init` scaffolding:
  - Optionally scaffold `references/awesome/` into generated projects so the refs live under the project directory
- Agent teams:
  - Scaffold `AGENTS.md` into generated projects with a recommended team topology and workflow

## Next

- Queryable catalog layer:
  - Parse the local awesome cache into a small dataset (SQLite or JSON)
  - Optional GitHub metadata enrichment (stars, last push, license)
  - Add a simple “compare options” workflow for solution-architect/security-engineer

## Later

- Agent teams:
  - Define a recommended “team topology” for `/sdlc:plan` and `/sdlc:review` (parallel subagent work products + synthesis)
  - Add scaffolding for team prompts/roles in generated projects (optional `AGENTS.md`)
