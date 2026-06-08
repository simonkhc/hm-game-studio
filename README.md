# Hermes Game Studio (HMGS)

A game development framework for **Hermes Agent**, adapted from [Claude Code Game Studios](https://github.com/Donchitos/Claude-Code-Game-Studios) by Donchitos.

Turn any Hermes Agent session into a structured game studio with specialized agents, phase-gated workflows, design templates, and quality gates — so you don't have to reinvent the process for every project.

---

## What You Get

| Category | Count | What it does |
|---|---|---|
| **Skills** | 74 | Step-by-step workflows — from concept brainstorming to release shipping. Each skill is 100-350 lines with branching logic, error handling, and edge cases. |
| **Agents** | 49 | Role-specific prompts for `delegate_task()`: 4 directors, 10 leads, 20 specialists, 15 engine experts (Godot/Unity/Unreal). |
| **Phases** | 7 | Structured pipeline: Concept → Systems Design → Technical Setup → Pre-Production → Production → Polish → Release. Each phase has a gate check. |
| **Templates** | 41 | GDDs, ADRs, UX specs, art bibles, release checklists, post-mortems — everything you need to document a game. |
| **Rules** | 11 | Path-scoped coding standards for gameplay, engine, UI, AI, networking, and more. |
| **Docs** | 16 | Framework reference: agent roster, coordination rules, gate definitions, quick-start guide, hooks reference. |
| **Hooks** | 12 | Bash scripts for CI/CD integration (pre-commit, post-checkout, session lifecycle, etc.) |

---

## Quick Start

```bash
# Clone alongside your game project
git clone https://github.com/simonkhc/hm-game-studio.git
cd your-game-project

# Start Hermes and activate the framework
hermes
> "I want to use the Hermes Game Studio framework."
> "Read hm-game-studio/FRAMEWORK.md to activate it."
```

For a new project:
```
> "Read hm-game-studio/skills/start/SKILL.md and guide me through."
```

For an existing project:
```
> "Read hm-game-studio/skills/adopt/SKILL.md to audit my project."
```

---

## The 7-Phase Pipeline

```
Phase 1 — Concept      → game-concept.md, pillars, systems index
Phase 2 — Systems Design → GDDs for each system (8-section format)
Phase 3 — Technical Setup → ADRs, architecture doc, control manifest
Phase 4 — Pre-Production   → UX specs, epics, stories, sprint plan
Phase 5 — Production       → implement stories sprint by sprint
Phase 6 — Polish           → performance, balance, playtesting, accessibility
Phase 7 — Release          → checklist, launch, publish
```

Each phase has a **gate check** before advancing. Gate intensity is configurable:

| Mode | Behavior | Best For |
|------|----------|----------|
| `full` | All gates active, director reviews | Teams, learning |
| `lean` | Phase gates only | Solo devs (default) |
| `solo` | No gates | Game jams, prototypes |

---

## How Skills Work

Skills are markdown files in `skills/<name>/SKILL.md`. Each has:

```yaml
name: bug-report
description: Creates a structured bug report with reproduction steps, severity classification, duplicate detection.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: qa-tester
```

To run a skill:
```
> "Read hm-game-studio/skills/gate-check/SKILL.md"
> "I need to file a bug — load the bug-report skill"
```

Or install permanently (for quick access):
```
> "Install the gate-check skill"
```
(Hermes will save it to `~/.hermes/skills/` for `skill_view('hmgs-gate-check')`.)

---

## Agents

49 role-specific prompts in `agents/`. Use with `delegate_task()`:

```
delegate_task(
    goal="Review this GDD for pillar alignment",
    context="..." + open("hm-game-studio/agents/creative-director.md").read()
)
```

Three tiers matching real studio hierarchy:
- **Directors** (tier 1): creative, technical, producer, art
- **Leads** (tier 2): game-designer, lead-programmer, narrative, audio, QA
- **Specialists** (tier 3): gameplay programmer, UI programmer, sound designer, etc.
- **Engine specialists**: Godot, Unity, Unreal (5 each)

---

## How It Compares

HMGS is a faithful port of CCGS v2 to Hermes Agent. It provides the same 7-phase pipeline, 49-agent hierarchy, quality gates, and design standards that CCGS is known for — but through Hermes-native tools (`skill_view`, `delegate_task`, `clarify`) instead of Claude Code's slash commands and hooks.

**What HMGS can't do that CCGS can:**
- Auto-trigger hooks on tool calls (CCGS runs pre-tool.sh automatically)
- Auto-load rules by file path (CCGS auto-applies `.claude/rules/`)
- Parse slash commands with arguments (`/adopt gdds`)
- Native agent spawning with automatic model routing

These are platform differences, not quality differences. HMGS delivers the same structured game development process within Hermes's capabilities.

---

## The Repo Structure

```
hm-game-studio/
├── FRAMEWORK.md          # Master config — collaboration protocol, agent system
├── ACTIVATE.md           # How to load the framework into a Hermes session
├── INDEX.md              # Complete file catalog (310 files)
├── skills/               # 74 skills, each in its own subdirectory
├── agents/               # 49 agent prompts
├── phases/               # 7 phase guides with gate checks
├── templates/            # 41 document templates
├── rules/                # 11 path-scoped coding standards
├── docs/                 # 16 framework docs
├── hooks/                # 12 bash hook scripts
├── agent-memory/         # Persistent memory seeds for agents
├── skill-testing/        # Framework QA (catalog, rubric, specs)
└── .github/              # Issue and PR templates
```

---

## License

MIT — same as CCGS.
