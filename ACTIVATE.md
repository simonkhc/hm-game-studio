# How to Activate the Hermes Game Studio Framework

## For the User

Start a Hermes session in your game project directory, then:

```
I want to use the Hermes Game Studio framework.
Read hm-game-studio/FRAMEWORK.md to activate it.
```

Or jump to a specific workflow:

```
I'm starting a new game project.
Read hm-game-studio/skills/start/SKILL.md and guide me through.
```

## For Hermes Agent

When the user says they want to use the framework:

### Step 1: Load Framework Context

1. Read `hm-game-studio/FRAMEWORK.md` — collaboration protocol, agent system, phase pipeline
2. Read `hm-game-studio/INDEX.md` — roadmap to all available files

### Step 2: Check for Existing Project State

- Read `production/stage.txt` if it exists → current phase
- Read `production/review-mode.txt` if it exists → review intensity
- Check `design/gdd/`, `docs/architecture/`, `production/epics/` for existing artifacts

### Step 3: Route to the Right Skill

| Situation | Skill to Load |
|---|---|
| New project | `hmgs-start` (or read `skills/start/SKILL.md`) |
| Existing project, first time with framework | `hmgs-adopt` |
| Know what you want to do | Load the specific skill |
| Not sure | `hmgs-help` or `hmgs-project-stage-detect` |

### Step 4: Create Project Directories if Needed

```
design/gdd/
design/ux/
design/quick-specs/
docs/architecture/
docs/engine-reference/
docs/postmortems/
production/sprints/
production/epics/
production/milestones/
production/playtests/
production/session-state/
production/bugs/
production/retrospectives/
assets/data/
src/gameplay/
src/ui/
src/ai/
src/networking/
src/core/
tests/
```

### Step 5: Use Agents When Appropriate

- For reviews/gates → `delegate_task()` with director agent prompts from `agents/`
- For design work → `delegate_task()` with lead agent prompts
- For implementation → `delegate_task()` with specialist agent prompts
- For decisions → `clarify` with structured options

## Skill Installation (Optional)

Skills can be installed for quick access:

```bash
# Each skill in skills/ can be loaded with:
skill_view(name='hmgs-<name>')
```

No installation command needed — skills are read directly from the repo.

## File Reference Convention

When this framework is active, all file paths in skills are relative to the **game project root** (the directory containing `hm-game-studio/`), NOT relative to the framework directory itself.

- Templates: `hm-game-studio/templates/[name].md`
- Agent prompts: `hm-game-studio/agents/[name].md`
- Skill guides: `hm-game-studio/skills/[name]/SKILL.md`
- Phase guides: `hm-game-studio/phases/[name].md`
