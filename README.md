# Claude SDLC Plugin

A Claude Code plugin that automates software development lifecycle (SDLC) workflows with an interactive Storybook-based planning hub.

**Generate professional SDLC artifacts with AI-assisted iterative planning.**

## What It Does

The SDLC plugin scaffolds complete software projects with proper documentation, then guides you through an iterative planning process that validates each stage with you before proceeding.

### Four Commands

| Command | Description |
|---------|-------------|
| `/sdlc:init` | Scaffold a monorepo with Storybook planning hub, design system, and quality tooling |
| `/sdlc:plan` | Interactive planning wizard - generates artifacts in dependency order with validation |
| `/sdlc:implement` | TDD implementation from validated planning artifacts with quality gates |
| `/sdlc:update` | Sync artifacts with implementation progress from git history |

### What Gets Generated

- **Requirements** - User stories, acceptance criteria, traceability matrix
- **Architecture** - System design, ADRs, OpenAPI specs, data models
- **UX Design** - Personas, user journeys, interactive prototypes
- **Quality** - Test plans, security reviews, code quality configs
- **Project Management** - Charter, WBS, risk register, schedules

## Installation

### Quick Start (Session Only)

```bash
claude --plugin-dir "/path/to/claude-sdlc-plugin"
```

### Global Installation

1. Clone the repository:
```bash
git clone https://github.com/45ck/claude-sdlc-plugin.git
```

2. Add to your Claude Code user settings (`~/.claude/settings.json`):
```json
{
  "enabledPlugins": {
    "sdlc@sdlc-local": true
  },
  "extraKnownMarketplaces": {
    "sdlc-local": {
      "url": "file:///path/to/claude-sdlc-plugin/.claude-plugin/marketplace.json"
    }
  }
}
```

3. Restart Claude Code - the plugin is now available globally.

### Prerequisites

- **Claude Code** v2.1+
- **pnpm** - For monorepo workspace management
- **Node.js 18+** - For Storybook and build tools
- **Git** - For version control

## Usage

### 1. Initialize a Project

```bash
/sdlc:init my-app
```

Creates:
```
my-app/
├── docs/                    # SDLC artifacts
├── packages/
│   ├── planning-hub/        # Storybook site
│   └── ui/                  # Design system
├── pnpm-workspace.yaml
├── package.json
└── ... (quality configs)
```

### 2. Start the Planning Hub

```bash
cd my-app
pnpm install
pnpm dev:storybook
```

Opens at http://localhost:6006

### 3. Plan Your Feature

```bash
/sdlc:plan
```

The wizard walks you through:

1. **Kickoff** - Project scope and constraints
2. **Scenarios** - As-is and visionary user scenarios
3. **Use Cases** - Activity diagrams and workflows
4. **Domain Model** - Class diagrams and entities
5. **Data Model** - ERD and database schema
6. **API Contract** - OpenAPI specification
7. **Prototypes** - Interactive Storybook components
8. **Sign-off** - Requirements traceability matrix

Each stage is validated with you before proceeding.

### 4. Track Implementation

```bash
/sdlc:update
```

Scans git commits and updates artifact status.

## Specialized Agents

The plugin includes expert subagents for different SDLC disciplines:

| Agent | Expertise |
|-------|-----------|
| `domain-analyst` | User stories, domain glossary, acceptance criteria |
| `solution-architect` | ADRs, OpenAPI specs, system design |
| `ux-prototyper` | Personas, user flows, Storybook components |
| `project-manager` | Charter, WBS, risk register, schedules |
| `business-analyst` | Process models, stakeholder maps, CATWOE |
| `security-engineer` | Threat models, auth design, compliance |
| `quality-engineer` | Quality models, metrics, tech debt tracking |

## Project Types

The plugin adapts generated artifacts based on project type:

| Type | Modules |
|------|---------|
| Web Application | Core + PM + Security + Quality + DB + DevOps |
| Mobile App | Core + PM + Security + Quality + DevOps |
| API/Backend | Core + PM + Security + Quality + DB + DevOps |
| Library/SDK | Core + Quality (lighter workflow) |
| Enterprise System | All modules + compliance |
| Academic Project | All modules (thesis/FYP ready) |

## Plugin Structure

```
claude-sdlc-plugin/
├── .claude-plugin/
│   ├── plugin.json          # Plugin manifest
│   └── marketplace.json     # For global installation
├── skills/
│   ├── init/SKILL.md        # /sdlc:init
│   ├── plan/SKILL.md        # /sdlc:plan
│   ├── implement/SKILL.md   # /sdlc:implement
│   └── update/SKILL.md      # /sdlc:update
├── agents/                   # Specialized subagents
├── hooks/                    # Auto-formatting, validation
└── scripts/                  # Helper scripts
```

## Configuration

### Customizing Templates

Templates are in `skills/*/templates/`. Edit to customize generated artifacts.

### Hooks

Hooks in `hooks/hooks.json` provide:
- **Auto-formatting** - Prettier on file save
- **OpenAPI validation** - Block invalid specs
- **pnpm check** - Verify prerequisites

Disable by renaming `hooks.json` to `hooks.json.disabled`.

## Troubleshooting

### pnpm not found

```bash
npm install -g pnpm
# or
corepack enable && corepack prepare pnpm@latest --activate
```

### Storybook won't start

```bash
rm -rf node_modules && pnpm install
pnpm storybook --no-manager-cache
```

### Plugin not loading

1. Check path in settings.json uses forward slashes or escaped backslashes
2. Verify marketplace.json exists at the configured URL
3. Restart Claude Code after settings changes

## Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make changes and test
4. Submit a pull request

## License

MIT License - see [LICENSE](LICENSE) for details.

## Credits

Created to bridge academic projects and industry SDLC practices.

---

**Version**: 1.0.0 | **Claude Code**: v2.1+ | **Updated**: 2026-01
