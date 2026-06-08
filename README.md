# Hermes Game Studio Framework

> **A game development framework for Hermes Agent** — adapted from [Claude Code Game Studios](https://github.com/Donchitos/Claude-Code-Game-Studios) by Donchitos.

Turn any Hermes Agent session into a structured game development studio with specialized agents, phase-gated workflows, and professional game design templates.

## Why This Exists

CCGS was built for Claude Code's slash commands, hooks, and rules system. **Hermes Game Studio** adapts the same design philosophy (MDA framework, 7-phase pipeline, collaborative design, 49-agent hierarchy) to Hermes Agent's native tools:

- `skill_view()` / `skill_manage()` for skill-based workflows
- `delegate_task()` for multi-agent orchestration
- `clarify` for structured decisions
- `read_file` / `write_file` / `patch` / `search_files` for file operations
- `terminal()` for builds, installs, and git
- `memory` for persistent project knowledge

## Quick Start

```
# In your game project root:
git clone https://github.com/your-org/hm-game-studio.git

# Then in Hermes:
"I want to use the Hermes Game Studio framework."
```

## What's Included

| Category | Count | Description |
|---|---|---|
| **Agents** | 49 | 4 directors, 10 leads, 20 specialists, 15 engine specialists |
| **Skills** | 73 | Step-by-step workflows for every game dev task |
| **Phases** | 7 | Full game dev pipeline from concept to release |
| **Templates** | 41 | GDDs, ADRs, specs, bibles, and more |
| **Docs** | 16 | Coding standards, coordination rules, references |

## Activation

See `ACTIVATE.md` for details. TL;DR:
1. Tell Hermes to read `FRAMEWORK.md`
2. Run `project-stage-detect` or `start` to begin
3. Work through the 7-phase pipeline

## License

MIT — same as CCGS.
