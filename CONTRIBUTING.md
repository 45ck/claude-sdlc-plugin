# Contributing to Claude SDLC Plugin

Thanks for your interest in contributing! This guide covers how to set up, develop, and submit changes.

## Development Setup

1. **Clone the repo:**
   ```bash
   git clone https://github.com/45ck/claude-sdlc-plugin.git
   cd claude-sdlc-plugin
   ```

2. **Load the plugin locally** in Claude Code:
   ```bash
   claude --plugin-dir "/path/to/claude-sdlc-plugin"
   ```

3. **Prerequisites:**
   - Claude Code v2.1+
   - pnpm (for generated monorepos)
   - Node.js 18+
   - Git

## Plugin Structure

```
claude-sdlc-plugin/
├── .claude-plugin/
│   ├── plugin.json          # Plugin manifest (name, version, entry points)
│   └── marketplace.json     # Enables global installation via settings.json
├── skills/                  # Slash commands
│   ├── init/SKILL.md        # /sdlc:init - project scaffolding
│   ├── plan/SKILL.md        # /sdlc:plan - interactive planning wizard
│   ├── implement/SKILL.md   # /sdlc:implement - TDD implementation from artifacts
│   └── update/SKILL.md      # /sdlc:update - progress tracking
├── agents/                  # Specialized subagents (domain-analyst, etc.)
├── hooks/                   # Auto-formatting, validation, env checks
├── scripts/                 # Shell scripts used by hooks
└── templates/               # File templates for generated artifacts
```

## Adding a New Skill

1. Create a directory under `skills/` with your skill name (e.g., `skills/my-skill/`).
2. Add a `SKILL.md` file with YAML frontmatter:
   ```markdown
   ---
   name: my-skill
   description: Short description of what the skill does.
   user-invocable: true
   allowed-tools: Read, Write, Edit, Bash, Glob, Grep
   ---

   # /sdlc:my-skill

   Instructions for Claude when this skill is invoked...
   ```
3. The skill becomes available as `/sdlc:my-skill` once the plugin is loaded.

## Adding a New Agent

1. Create a directory under `agents/` with the agent name (e.g., `agents/my-agent/`).
2. Add an `agent.md` file defining the agent's role, expertise, and instructions.
3. Reference the agent from skills that need it using the `Task` tool with the agent name.

## Adding or Editing Templates

Templates live alongside their skills in `skills/*/templates/` or in the top-level `templates/` directory. These are the files that get generated into user projects.

- Use `{{placeholder}}` syntax for values that get filled at generation time.
- Keep templates minimal and well-commented so users can customize them.

## Testing Changes

Since this is a Claude Code plugin (prompt-based, not compiled), testing is manual:

1. Load the plugin with `claude --plugin-dir`.
2. Run each skill (`/sdlc:init`, `/sdlc:plan`, `/sdlc:implement`, `/sdlc:update`) and verify the output.
3. Test hooks by editing files in a generated project and confirming auto-formatting and validation fire.
4. Test on both Windows and macOS/Linux if possible (scripts should be cross-platform).

## Pull Request Guidelines

1. **Fork** the repo and create a feature branch from `master`.
2. **Keep changes focused** - one feature or fix per PR.
3. **Update documentation** if your change affects user-facing behavior:
   - `README.md` for usage changes
   - `CHANGELOG.md` for notable additions or fixes
4. **Test your changes** manually with Claude Code before submitting.
5. **Write a clear PR description** explaining what changed and why.

## Reporting Issues

Open an issue on [GitHub](https://github.com/45ck/claude-sdlc-plugin/issues) with:
- Steps to reproduce
- Expected vs. actual behavior
- Claude Code version and OS

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
