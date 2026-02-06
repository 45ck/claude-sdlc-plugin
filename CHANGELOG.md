# Changelog

All notable changes to the SDLC Plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.1] - 2026-02-07

### Added
- `/sdlc:refs` skill for syncing/searching local reference repos (curated `awesome-*` lists)
- Curated awesome seed list + sync script (plugin-level and `/sdlc:init` scaffolding templates)
- Planning + agent guidance to use local references as a tech discovery/index layer
- `AGENTS.md` scaffolding template for generated projects (agent teams / working agreements)
- Team mode guidance in `/sdlc:plan` (AskUserQuestion: Solo vs Team; parallel subagents + synthesis)

### Fixed / Improved
- `/sdlc:plan` flow now explicitly requires choosing Solo vs Team before proceeding
- Awesome refs sync now writes `references/awesome/LOCK.json` for auditability/reproducibility
- Catalog search: domain penalties/filters + fallback when SQLite FTS5 is unavailable
- Added `scripts/smoke.sh` to prevent script/template regressions

### Changed
- Updated `solution-architect`, `security-engineer`, and `quality-engineer` agents to use local awesome references when available

## [1.1.0] - 2026-01-26

### Added
- `/sdlc:review` skill for design verification against planning artifacts (API spec, ERD, domain model, acceptance criteria)
- `/sdlc:qa` skill for quality assurance verification with coverage thresholds, test quality assessment, and quality scoring
- **review-auditor** subagent for cross-artifact conformance checking (read-only, uses Opus model)
- Fix-forward mode in `/sdlc:qa` for generating test stubs and E2E scaffolds
- Coverage trend tracking in `docs/qa/coverage-trend.csv`
- Deviations log in `docs/review/deviations-log.md`

### Changed
- Updated `quality-engineer` agent with `/sdlc:qa` skill
- Updated `security-engineer` agent with `/sdlc:qa` and `/sdlc:review` skills
- Updated `solution-architect` agent with `/sdlc:review` skill
- Updated `domain-analyst` agent with `/sdlc:review` skill
- Added "Next Steps" guidance to `/sdlc:implement` skill
- Added verification status block to `/sdlc:update` progress report

## [1.0.0] - 2026-01-26

### Added
- `/sdlc:init` skill for monorepo scaffolding with Storybook planning hub
- `/sdlc:plan` skill for interactive planning workflows with intelligent module inference
- `/sdlc:implement` skill for TDD implementation from validated planning artifacts
- `/sdlc:update` skill for progress tracking and artifact synchronization
- **domain-analyst** subagent for business requirements and user stories
- **solution-architect** subagent for technical architecture (uses Opus model)
- **ux-prototyper** subagent for UX design and component stories
- **project-manager** subagent for project planning and coordination
- **business-analyst** subagent for business analysis and process modeling
- **security-engineer** subagent for security architecture and threat modeling
- **quality-engineer** subagent for software quality assurance
- Auto-formatting hook (PostToolUse) using Prettier
- OpenAPI validation hook (PreToolUse) using openapi-validator
- pnpm check hook (SessionStart) for environment verification
- Storybook planning hub with MDX 3 support
- Mermaid diagram rendering for UML, BPMN, and flowcharts
- Swagger UI integration for API documentation
- Design system package with tokens and primitives
- Requirements Traceability Matrix (RTM) support
- Module-based artifact generation (PM, BA, Security, Quality, DB, DevOps)
- Diamond interview structure for requirements discovery

### Module Support
- **Core Modules** (always generated): Requirements, Architecture, UX, Testing
- **Project Management**: Charter, WBS, schedule, risk register, communications plan
- **Business Analysis**: Stakeholder maps, CATWOE, process models, root definitions
- **Security**: Threat models, auth design, security test plans, compliance checklists
- **Quality**: Quality models, metrics, tech debt registers, refactoring plans
- **Database**: Schema design, ER diagrams, migrations, indexing strategy
- **DevOps**: Deployment architecture, CI/CD, observability, IaC templates

### Compliance & Standards
- ISO/IEC 27001 (Information Security)
- Essential Eight (Australian Cyber Security Centre)
- SOC 2 (Service Organization Control)
- WCAG 2.1 AA (Web Content Accessibility Guidelines)

### Technical Stack
- pnpm workspace monorepo
- Storybook (latest) with React + Vite
- MDX 3 for documentation
- Mermaid for diagrams
- OpenAPI 3.0/3.1 for API specifications
- CSV for traceability matrices and risk registers

### Infrastructure
- Git integration with auto-commit support
- Artifact auto-reload (watch mode)
- Static site generation for Storybook
- Cross-platform script compatibility (Windows, macOS, Linux)

[1.1.0]: https://github.com/45ck/claude-sdlc-plugin/releases/tag/v1.1.0
[1.0.0]: https://github.com/45ck/claude-sdlc-plugin/releases/tag/v1.0.0
[1.1.1]: https://github.com/45ck/claude-sdlc-plugin/releases/tag/v1.1.1
