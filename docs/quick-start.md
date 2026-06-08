# Quick Start Guide

## First-Time Setup

1. Clone HMGS alongside your game project:
   ```
   git clone https://github.com/your-org/hm-game-studio.git
   ```

2. Start a Hermes session in your game project directory:
   ```
   hermes
   ```

3. Activate the framework:
   ```
   I want to use the Hermes Game Studio framework.
   Read hm-game-studio/FRAMEWORK.md to activate it.
   ```

4. Start the onboarding:
   ```
   I'm starting a new game project.
   Read hm-game-studio/skills/start/SKILL.md and guide me through.
   ```

## Alternative: Brownfield Adoption

If you already have a game project with code:

```
I have an existing game project. Read hm-game-studio/skills/adopt/SKILL.md.
```

## Minimal Setup

For a game jam, you just need:

1. `production/stage.txt` — set to `concept`
2. `production/review-mode.txt` — set to `solo`
3. A game concept idea

## Key Hermes Tools for This Framework

| Tool | Usage |
|------|-------|
| `skill_view(name)` | Load a skill to execute |
| `skill_manage(action='create')` | Install a new skill permanently |
| `delegate_task(goal, context)` | Spawn an agent for a subtask |
| `delegate_task(tasks=[...])` | Run multiple agents in parallel |
| `clarify(question, choices)` | Structured user decision |
| `read_file(path)` | Read project files |
| `write_file(path, content)` | Write project files |
| `patch(path, old, new)` | Targeted file edits |
| `search_files(pattern, path)` | Search code/design docs |
| `terminal(command)` | Run builds, git, scripts |
| `memory(action, content)` | Persist project knowledge |
