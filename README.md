# SDLC Plugin for Claude Code

Comprehensive SDLC workflow automation plugin that scaffolds monorepo projects with a Storybook-based planning hub covering the full software development lifecycle.

## Overview

The SDLC plugin helps teams and students implement industry-standard software engineering practices by automating the creation and management of SDLC artifacts. It generates structured documentation across:

- **Project Management** - Charter, WBS, schedule, risk register, communications plan
- **Business Analysis** - Stakeholder maps, process models, CATWOE analysis, problem statements
- **Requirements** - Vision, SRS/PRD, user stories, NFRs, requirements traceability matrix
- **Architecture** - System design, ADRs, data models, API specifications
- **Security** - Threat models, auth design, security test plans, compliance checklists
- **Quality** - Quality models, metrics, tech debt registers, refactoring plans
- **Testing & Verification** - Test strategy, test plans, mutation testing
- **UX & Design** - Personas, user journeys, usability test plans, accessibility checklists
- **Database** - Schema design, migrations, indexing strategy
- **DevOps** - Deployment architecture, CI/CD plans, observability strategy

## Features

### Three Core Skills

- **`/sdlc:init`** - Scaffolds monorepo with Storybook planning hub, design system, and documentation structure
- **`/sdlc:plan`** - Runs discovery wizard, infers project type, generates appropriate SDLC modules
- **`/sdlc:update`** - Syncs artifacts with implementation status, updates traceability matrices

### Specialized Subagents

- **domain-analyst** - Business requirements and user story expert
- **solution-architect** - Technical architecture and API design expert (uses Opus model)
- **ux-prototyper** - UX design and Storybook component story expert
- **project-manager** - Project management and planning expert
- **business-analyst** - Business analysis and process modeling expert
- **security-engineer** - Security design and threat modeling expert
- **quality-engineer** - Software quality and metrics expert

### Intelligent Module Inference

The plugin automatically determines which SDLC modules to generate based on your project type:

| Project Type | Generated Modules |
|--------------|-------------------|
| Web application | Core + PM + BA + Security + Quality + DB + DevOps |
| Mobile app | Core + PM + Security + Quality + DevOps |
| API/Backend service | Core + PM + Security + Quality + DB + DevOps |
| Library/SDK | Core + Quality (lighter workflow) |
| Enterprise system | All modules + compliance checklists |
| Academic project | All modules (FYP-ready) |

### Storybook Planning Hub

Interactive documentation site with:
- Unified navigation across all SDLC phases
- Live Mermaid diagram rendering (UML, BPMN, flowcharts)
- Interactive API documentation (OpenAPI/Swagger UI)
- Requirements traceability matrix
- Design system with tokens and primitives
- Auto-reload on artifact changes

## Installation

Install the plugin by adding it to your Claude Code configuration:

```bash
claude code --plugin-dir="D:\Visual Studio Projects\sdlc-plugin"
```

Or add to your `.claude/config.json`:

```json
{
  "plugins": ["D:\\Visual Studio Projects\\sdlc-plugin"]
}
```

## Prerequisites

- **pnpm** - Required for monorepo workspace management
- **Git** - For version control
- **Node.js 18+** - For Storybook and build tools

## Quick Start

### 1. Initialize a New Project

```bash
/sdlc:init my-project
```

This creates:
- Monorepo structure with pnpm workspace
- Storybook planning hub
- Design system package
- Git repository with initial commit
- Sample documentation templates

### 2. Install Dependencies

```bash
cd my-project
pnpm install
```

### 3. Start Planning Hub

```bash
pnpm dev:storybook
```

Opens Storybook at http://localhost:6006

### 4. Plan Your First Feature

```bash
/sdlc:plan
```

This runs an interactive wizard that:
- Classifies your project type
- Asks targeted questions about requirements
- Infers which SDLC modules to generate
- Invokes specialized subagents to create artifacts
- Generates MDX pages in Storybook

### 5. Sync Implementation Progress

After implementing features:

```bash
/sdlc:update
```

This:
- Analyzes git commits for completed work
- Updates artifact status and checkboxes
- Marks completed items in requirements traceability matrix
- Generates progress reports

## Skills Reference

### `/sdlc:init [project-name]`

**Purpose**: Initialize a new SDLC monorepo project

**Arguments**:
- `project-name` (optional) - Name of the project

**What It Creates**:
- `pnpm-workspace.yaml` - Monorepo configuration
- `packages/planning-hub/` - Storybook documentation site
- `packages/ui/` - Design system package
- `docs/` - Source artifacts directory structure
- `.git/` - Git repository with initial commit

**Example**:
```bash
/sdlc:init ecommerce-platform
```

### `/sdlc:plan`

**Purpose**: Create planning artifacts through guided discovery

**Plan Types**:
- Feature planning (full SDLC coverage)
- Architecture Decision Record (ADR)
- API specification
- UX prototype

**Workflow**:
1. **Phase 1**: Closed questions (project classification)
2. **Phase 2**: Open questions (requirements discovery)
3. **Phase 3**: Closed questions (validation & standards)
4. **Phase 4**: Artifact generation (invokes subagents)
5. **Phase 5**: Output & next steps

**Example**:
```bash
/sdlc:plan
# Interactive wizard starts...
```

### `/sdlc:update`

**Purpose**: Synchronize artifacts with implementation status

**What It Does**:
- Scans codebase for implementations
- Checks git history for related commits
- Updates artifact status and checkboxes
- Marks completed items in RTM
- Adds implementation notes
- Generates progress reports

**Example**:
```bash
/sdlc:update
```

## Subagents

### domain-analyst

**Specialization**: Business requirements and domain modeling

**Creates**:
- User stories (INVEST principles)
- Domain glossary (ubiquitous language)
- Acceptance criteria
- Business value documentation

**Model**: Sonnet (cost-effective for requirements work)

### solution-architect

**Specialization**: Technical architecture and system design

**Creates**:
- Architecture Decision Records (ADRs)
- OpenAPI 3.0 specifications
- System architecture diagrams (Mermaid)
- Data models (ER diagrams, class diagrams)
- Technical task breakdowns

**Model**: Opus (complex technical reasoning)

**Special Features**:
- Auto-validates OpenAPI specs via hook
- Uses SOLID principles and 12-Factor App methodology
- Security-by-design approach

### ux-prototyper

**Specialization**: User experience and component design

**Creates**:
- Storybook component stories (MDX)
- User flow diagrams (Mermaid)
- Design tokens (colors, spacing, typography)
- Accessibility documentation (WCAG 2.1 AA)

**Model**: Sonnet
**Permission Mode**: acceptEdits (optimized for UI work)

### project-manager

**Specialization**: Project planning and coordination

**Creates**:
- Project charter
- Work Breakdown Structure (WBS)
- Schedule and milestones
- Risk register (CSV format)
- Communications plan
- Closure checklist

**Model**: Sonnet

### business-analyst

**Specialization**: Business analysis and process improvement

**Creates**:
- Stakeholder maps
- Process models (as-is/to-be BPMN)
- CATWOE analysis
- Root definitions (Soft Systems Methodology)
- Rich pictures
- Problem statements

**Model**: Sonnet

### security-engineer

**Specialization**: Security architecture and threat modeling

**Creates**:
- Threat models (STRIDE methodology)
- Authentication/authorization design
- Security requirements
- Security test plans (OWASP/WSTG)
- Compliance checklists (ISO 27001, Essential Eight, WCAG)

**Model**: Sonnet

### quality-engineer

**Specialization**: Software quality assurance

**Creates**:
- Quality models and attributes
- Code metrics and targets
- Technical debt registers
- Code review checklists
- Static analysis configuration
- Refactoring plans

**Model**: Sonnet

## Hooks

### PostToolUse: Auto-Formatting

**Trigger**: After Write or Edit tool operations

**Script**: `scripts/format.sh`

**Purpose**: Automatically format files with Prettier

**Supported File Types**:
- JavaScript/TypeScript (.js, .ts, .jsx, .tsx)
- JSON (.json)
- Markdown/MDX (.md, .mdx)
- YAML (.yaml, .yml)

**Behavior**: Non-blocking (exit 0) - always succeeds even if Prettier not installed

### PreToolUse: OpenAPI Validation

**Trigger**: Before Write or Edit operations

**Script**: `scripts/validate-openapi.sh`

**Purpose**: Validate OpenAPI specifications before writing

**Behavior**: Blocking (exit 2 on validation failure) - prevents invalid specs

### SessionStart: pnpm Check

**Trigger**: When Claude Code session starts

**Script**: `scripts/helpers/check-pnpm.sh`

**Purpose**: Verify pnpm is installed

**Behavior**: Non-blocking (exit 0) - warns if not installed but continues

## Project Structure

### Plugin Directory

```
sdlc-plugin/
├── .claude-plugin/
│   └── plugin.json              # Plugin manifest
├── skills/
│   ├── init/
│   │   ├── SKILL.md            # Initialization skill
│   │   └── templates/          # Project templates
│   ├── plan/
│   │   ├── SKILL.md            # Planning skill
│   │   └── templates/          # Artifact templates
│   └── update/
│       └── SKILL.md            # Update skill
├── agents/
│   ├── domain-analyst.md
│   ├── solution-architect.md
│   ├── ux-prototyper.md
│   ├── project-manager.md
│   ├── business-analyst.md
│   ├── security-engineer.md
│   └── quality-engineer.md
├── hooks/
│   └── hooks.json              # Hook configuration
├── scripts/
│   ├── format.sh               # Auto-formatting
│   ├── validate-openapi.sh     # OpenAPI validation
│   └── helpers/
│       └── check-pnpm.sh       # pnpm detection
├── README.md
├── CHANGELOG.md
├── LICENSE
└── .gitignore
```

### Generated Project Directory

```
my-project/
├── pnpm-workspace.yaml         # Monorepo configuration
├── docs/                       # Source artifacts
│   ├── pm/                     # Project Management
│   ├── ba/                     # Business Analysis
│   ├── req/                    # Requirements
│   ├── arch/                   # Architecture
│   ├── security/               # Security
│   ├── quality/                # Quality
│   ├── test/                   # Testing
│   ├── ux/                     # UX & Design
│   ├── db/                     # Database
│   └── ops/                    # DevOps
├── packages/
│   ├── planning-hub/           # Storybook site
│   │   ├── .storybook/
│   │   ├── src/
│   │   │   ├── docs/           # MDX pages
│   │   │   ├── components/     # MermaidDiagram, SwaggerViewer
│   │   │   └── utils/
│   │   └── scripts/
│   │       └── sync-artifacts.js
│   └── ui/                     # Design system
│       └── src/
│           ├── tokens/         # Design tokens
│           └── primitives/     # Button, Input, etc.
└── package.json
```

## Configuration

### Customizing Templates

Templates are located in `skills/init/templates/` and `skills/plan/templates/`.

To customize:
1. Edit template files (use `{{VARIABLE}}` for placeholders)
2. Modify skill logic in `skills/*/SKILL.md` if needed

### Overriding Hooks

Edit `hooks/hooks.json` to:
- Disable hooks (remove entries)
- Change hook matchers
- Modify hook commands
- Add new hooks

### Extending Skills

Skills are defined in `skills/*/SKILL.md` with YAML frontmatter.

Skill frontmatter structure:
```yaml
---
name: skill-name
description: What this skill does
disable-model-invocation: false
user-invocable: true
argument-hint: [optional-arguments]
allowed-tools: Bash, Write, Read, Glob, Grep
model: sonnet
---
```

## Troubleshooting

### pnpm not found

**Error**: `command not found: pnpm`

**Solution**:
```bash
# Option 1: Install globally via npm
npm install -g pnpm

# Option 2: Enable corepack (Node 16.13+)
corepack enable
corepack prepare pnpm@latest --activate
```

### Storybook won't start

**Error**: Storybook fails to start or shows errors

**Solutions**:
1. Clear cache: `pnpm run storybook --no-manager-cache`
2. Reinstall dependencies: `rm -rf node_modules && pnpm install`
3. Check Node version: `node --version` (requires 18+)
4. Check for port conflicts: `lsof -i :6006` (macOS/Linux) or `netstat -ano | findstr :6006` (Windows)

### Artifacts not syncing

**Error**: Changes in `docs/` don't appear in Storybook

**Solutions**:
1. Check sync script is running: Look for "Watching docs directory..." message
2. Restart Storybook: `pnpm dev:storybook`
3. Manual sync: `pnpm run sync:artifacts`
4. Check file permissions on `docs/` and `packages/planning-hub/public/artifacts/`

### OpenAPI validation failures

**Error**: `OpenAPI validation failed`

**Solutions**:
1. Check OpenAPI syntax: https://editor.swagger.io
2. Ensure `openapi: 3.0.0` or `openapi: 3.1.0` at top of file
3. Validate required fields:
   - `info.title` and `info.version` are required
   - All paths must have operation objects
   - Schema references must use `$ref` correctly
4. Bypass validation (not recommended): Comment out PreToolUse hook in `hooks/hooks.json`

### Hook errors

**Error**: Hooks failing or blocking operations

**Debug Steps**:
1. Check hook script permissions: `ls -l scripts/*.sh`
2. Test hook manually: `bash scripts/format.sh < test-input.json`
3. View hook logs in Claude Code output
4. Temporarily disable hooks: Remove from `hooks/hooks.json`

## Best Practices

### Planning Workflow

1. **Start with `/sdlc:init`** - Set up project structure first
2. **Run `/sdlc:plan` early** - Discover requirements before coding
3. **Iterate** - Use planning hub to refine understanding
4. **Review with stakeholders** - Share Storybook site for feedback
5. **Keep artifacts updated** - Run `/sdlc:update` after major implementations

### Artifact Organization

1. **Keep docs/ clean** - Source of truth for all artifacts
2. **Use consistent naming** - Follow established patterns
3. **Link artifacts** - Reference related documents
4. **Version control** - Commit artifact changes to git
5. **Traceability** - Maintain RTM (Requirements Traceability Matrix)

### Collaboration

1. **Deploy planning hub** - `pnpm build:storybook` creates static site
2. **Share with team** - Deploy to Vercel, Netlify, or GitHub Pages
3. **Review in Storybook** - Visual review process
4. **Use design system** - Consistent UI from planning to implementation

## Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

MIT License - see LICENSE file for details

## Credits

Created for University of Newcastle (UON) Computer Science curriculum alignment.

Designed to bridge the gap between academic projects and industry-standard SDLC practices.

---

**Plugin Version**: 1.0.0
**Claude Code Version**: Latest
**Last Updated**: 2026-01-25
