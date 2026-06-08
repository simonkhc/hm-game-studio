# Hermes Game Studio — Framework Configuration

**Version:** 1.0.0
**Last Updated:** 2026-06-08
**Based on:** CCGS v2 by Donchitos (MIT License) — adapted for Hermes Agent

---

## What This Is

Hermes Game Studio (HMGS) is a full game development framework for **Hermes Agent**, adapted from [Claude Code Game Studios](https://github.com/Donchitos/Claude-Code-Game-Studios) by Donchitos.

Where CCGS used Claude Code's slash commands, hooks, and automatic rules to drive the pipeline, HMGS uses Hermes-native constructs:

| CCGS Concept | HMGS Equivalent |
|---|---|
| `/command` slash skills | Hermes skills (`skill_view` / `skill_manage`) |
| `.claude/hooks/` (auto-triggered) | Skill-embedded pre/post steps (manual, reliable) |
| `.claude/rules/` (path-scoped auto-load) | Memory-injected rules + per-domain skill files |
| `spawn_agent()` (Claude sub-agents) | `delegate_task()` (Hermes sub-agents) |
| `AskUserQuestion` | `clarify` |
| `Read` / `Glob` / `Grep` / `Write` | `read_file` / `search_files` / `patch` / `write_file` |
| `agent-memory/` | `memory` tool |
| `session-state/` | `session_search` |

---

## When This Framework Is Active

When Hermes loads the HMGS framework (via `skill_view(name='hmgs-activate')` or by reading this file), follow these rules for the entire session.

---

## Collaboration Protocol

**User-driven, not autonomous.** Every task follows:

```
Question → Options → Decision → Draft → Approval → Execute
```

1. **Question** — Ask clarifying questions before proposing solutions
2. **Options** — Present 2-4 options with pros/cons
3. **Decision** — User decides. Use `clarify` for structured choices.
4. **Draft** — Show in conversation first
5. **Approval** — "May I write this to [path]?" before writing
6. **Execute** — Write/run with proper tool

### When to Use `clarify` vs Plain Conversation

| Situation | Method |
|---|---|
| 2-4 clear options, user picks one | `clarify` with choices |
| Open discussion, exploration | Plain conversation |
| Confirming danger/irreversible action | Plain question, not `clarify` |
| Post-task feedback | `clarify` |

---

## Agent System

Use `delegate_task()` with prompts from `agents/`. Agents are organized in 3 tiers:

```
Tier 1 — Directors (strategic oversight)
  creative-director, technical-director, producer, art-director

Tier 2 — Leads (domain ownership)
  game-designer, lead-programmer, narrative-director, audio-director,
  qa-lead, release-manager, localization-lead, systems-designer,
  level-designer, economy-designer

Tier 3 — Specialists (execution)
  gameplay-programmer, engine-programmer, ai-programmer, network-programmer,
  tools-programmer, ui-programmer, technical-artist, sound-designer, writer,
  world-builder, ux-designer, prototyper, performance-analyst, qa-tester,
  devops-engineer, analytics-engineer, security-engineer,
  accessibility-specialist, live-ops-designer, community-manager
```

Engine specialists (Godot 4, Unity, Unreal 5) — see `agents/` for 15 engine-specific agents.

### Coordination Rules

- **Vertical delegation:** Directors → Leads → Specialists. Never skip tiers for complex decisions.
- **Horizontal consultation:** Same-tier agents may consult but not make binding cross-domain decisions.
- **Conflict resolution:** Design conflicts → creative-director. Technical conflicts → technical-director. Scope conflicts → producer.
- **Parallel spawning:** Independent agents via `delegate_task(tasks=[...])` — up to 3 per batch.
- **Sequential spawning:** Dependent agents one at a time.

### When to Use `delegate_task`

- Reasoning-heavy subtasks (design reviews, code review, research)
- Tasks needing specialized knowledge (engine-specific questions)
- Parallel independent audits (check GDDs and ADRs simultaneously)
- Quality gates (spawn a director for review)

Do NOT use `delegate_task` for:
- Simple file reads or writes (use tools directly)
- Tasks requiring user interaction (subagents can't use `clarify`)
- Mechanical multi-step work with no reasoning needed

---

## Phase Pipeline

The 7-phase pipeline. Each phase has a gate check before advancing.

```
Phase 1: Concept       → game-concept.md, pillars, systems index
Phase 2: Systems Design → GDDs for each system
Phase 3: Technical Setup → ADRs, architecture, control manifest
Phase 4: Pre-Production  → UX specs, epics, stories, sprint plan, vertical slice
Phase 5: Production      → implement stories sprint by sprint
Phase 6: Polish          → performance, balance, playtesting, accessibility
Phase 7: Release         → checklist, launch, publish
```

### Review Modes

Set via `production/review-mode.txt`:

| Mode | Director Gates | Best For |
|------|---------------|----------|
| `full` | All gates at every step | New projects, teams |
| `lean` | Gates only at phase transitions | Experienced devs (default) |
| `solo` | No gates | Game jams, prototypes |

---

## How to Load a Skill

When the user asks for a framework workflow:

1. Load the Hermes skill with `skill_view(name='hmgs-<skillname>')`
2. Follow its instructions step by step
3. Use Hermes tools (`read_file`, `write_file`, `patch`, `search_files`, `terminal`, `delegate_task`, `clarify`, etc.)
4. Each skill includes pre-checks, step sequence, output artifact, and post-checks

If a skill is not yet installed as a Hermes skill, read it from `skills/<skillname>/SKILL.md` directly.

---

## File Conventions

### Required Directories (in the game project, not the framework)

```
design/gdd/               — Game Design Documents
design/ux/                — UX specifications
design/quick-specs/       — Lightweight design changes
docs/architecture/        — ADRs and architecture docs
docs/engine-reference/    — Version-pinned engine docs
production/stage.txt      — Current phase
production/review-mode.txt — Review intensity
production/session-state/ — Session checkpoints (gitignored)
production/sprints/       — Sprint plans
production/epics/         — Epics and stories
production/playtests/     — Playtest reports
production/bugs/          — Bug reports
assets/data/              — Configurable game data (JSON)
src/                      — Game source code
tests/                    — Test suites
prototypes/               — Throwaway experiments
```

### GDD Standard

Every GDD must have these 8 sections:
1. **Overview** — One-paragraph summary
2. **Player Fantasy** — What the player imagines/feels
3. **Detailed Rules** — Unambiguous mechanical rules
4. **Formulas** — Every calculation with variable definitions
5. **Edge Cases** — Explicitly resolved weird situations
6. **Dependencies** — Connected systems (bidirectional)
7. **Tuning Knobs** — Values designers can safely change
8. **Acceptance Criteria** — Testable completion conditions

### Data-Driven Design

All tunable values go in `assets/data/` — never hardcoded in source.

---

## Design Frameworks

### MDA Framework (Hunicke, LeBlanc, Zubek)

Design from player experience backward:
- **Aesthetics** (what the player FEELS): Sensation, Fantasy, Narrative, Challenge, Fellowship, Discovery, Expression, Submission
- **Dynamics** (emergent behaviors from mechanics)
- **Mechanics** (the rules we build)

### Self-Determination Theory

Every system should satisfy at least one of:
- **Autonomy** — meaningful choices
- **Competence** — clear skill growth with readable feedback
- **Relatedness** — connection to characters, world, or other players
