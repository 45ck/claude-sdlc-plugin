# Changelog

All notable changes to the SDLC Plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned Features
- Phase 1: Plugin Foundation
- Phase 2: Template Files
- Phase 3: Skills Implementation
- Phase 4: Subagents Implementation
- Phase 5: Hooks and Scripts
- Phase 6: Storybook Planning Hub
- Phase 7: Design System Package
- Phase 8: Testing and Validation
- Phase 9: Documentation

## [1.0.0] - TBD

### Added
- `/sdlc:init` skill for monorepo scaffolding with Storybook planning hub
- `/sdlc:plan` skill for interactive planning workflows with intelligent module inference
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

[Unreleased]: https://github.com/anthropics/claude-code-sdlc-plugin/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/anthropics/claude-code-sdlc-plugin/releases/tag/v1.0.0
