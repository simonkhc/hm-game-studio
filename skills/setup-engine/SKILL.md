name: setup-engine
description: Configure engine, pin exact version, detect knowledge gaps, populate technical preferences and engine reference docs. Detects whether the engine version is newer than the LLM's training data and flags API differences. Configures engine-specialist agents.
allowed-tools: read_file, write_file, terminal, clarify, search_files, web_search
model: sonnet
agent: technical-director

Setup Engine — Technical Configuration

Configures the game engine: pins the exact version, documents conventions, sets performance budgets, and creates engine reference docs. Essential first step before any code is written.

Output: docs/technical-preferences.md + optional docs/engine-reference/[engine]/VERSION.md

---

Phase 1: Determine Engine

Ask: "Which engine are you using?"
If the user is unsure: present the standard options:
- "Godot 4 — open source, lightweight, great 2D, GDScript or C#"
- "Unity — free tier, C#, huge asset store, 2D and 3D"
- "Unreal 5 — free with 5% royalty after $1M, C++/Blueprints, high-end 3D"
- "Custom / Other" — prompt for specifics

If a project.godot / Packages/manifest.json / .uproject file exists: detect engine automatically.

---

Phase 2: Pin Exact Version

Ask: "What exact version? (e.g., 4.4, 2022.3.48f1, 5.5)"
If the user says "latest": "I need an exact version for reproducibility. What's the latest stable you're using?"
If the user doesn't know: try to detect from engine files:
- Godot: check project.godot header or engine version string
- Unity: read ProjectSettings/ProjectVersion.txt or Packages/manifest.json
- Unreal: read .uproject file's "EngineAssociation" field

If detection fails: "Please check the engine's About/Help menu for the exact version."

---

Phase 3: Language Decision

Ask: "What programming language?"
Depends on engine:
- Godot: GDScript (default), C# (.NET), or GDExtension (C++/Rust)
- Unity: C# (default)
- Unreal: C++ (default), Blueprints (visual scripting)

If the user doesn't know: pick the engine's primary/default language.

---

Phase 4: Version Safety Check

THIS IS CRITICAL: Check if the engine version is newer than the LLM's training data cutoff.
General rule of thumb: if the engine version was released in the last 12 months, it may be post-cutoff.

If post-cutoff: add a prominent warning to technical-preferences.md:
```
> ⚠️ **Engine version [version] may be newer than my training data.**
> Cross-reference ALL API calls with the official engine documentation before implementing.
> Key areas to verify: scene/node APIs, input system, rendering methods, audio system.
```

Create docs/engine-reference/[engine]/VERSION.md with known API differences from training data:
- For Godot 4.4 (current): note TileMap→TileMapLayer migration, @export annotation requirement, typed arrays
- For Unity 2022.3+: note DOTS changes, Input System package, Addressables updates
- For Unreal 5.5+: note Enhanced Input, World Partition updates

---

Phase 5: Configure Conventions

Ask the user about naming:
- Scenes: PascalCase (e.g., MainMenu.tscn) ✓ most common
- Scripts: snake_case.gd or PascalCase.cs (engine-dependent)
- Variables: snake_case or camelCase (engine-dependent)
- Constants: UPPER_CASE

If the user doesn't care: use the engine's community standard conventions.
- "I'll set the standard conventions for [engine]. Change them later if needed."

---

Phase 6: Set Performance Budgets

Ask about target platform to determine budgets:
"Primary target platform?"
Options: Desktop (Windows/Mac/Linux) / Mobile (Android/iOS) / Web (HTML5) / Console

Suggested defaults:
| Target | FPS | RAM | VRAM | Load time |
| Desktop | 60 | 2GB+ | 1GB | 5s |
| Mobile | 30 | 512MB | 256MB | 10s |
| Web | 30 | 1GB | 512MB | 10s |
| Console | 30/60 | varies | varies | varies |

If the user disagrees: accept their targets.

---

Phase 7: Write Configuration

Write to docs/technical-preferences.md:

```
# Technical Preferences

> **Last updated:** [date]

## Engine
- **Engine:** [name] [version]
- **Language:** [language]
- **Target platforms:** [list]

## Version Safety
[Post-cutoff warning if applicable]

## Naming Conventions
- Scenes/Levels: PascalCase (e.g., Level01.tscn)
- Scripts: [snake_case / PascalCase]
- Variables: [snake_case / camelCase]
- Constants: UPPER_CASE
- Signals/Events: [snake_case / PascalCase]

## Performance Budgets
- Target FPS: [N]
- RAM budget: [N] MB
- VRAM budget: [N] MB
- Max load time: [N] seconds
- [For 3D] Draw call budget: [N]

## Code Organization
- src/core/ — Engine/framework code
- src/gameplay/ — Gameplay systems
- src/ui/ — Interface code
- src/ai/ — AI behavior
- src/networking/ — Multiplayer code

## Forbidden Patterns
- No hardcoded magic numbers (use config files)
- No singletons for game state (dependency injection preferred)
- [Engine-specific forbidden patterns]

## Allowed Libraries
- [List of approved third-party libraries]
```

---

Phase 8: Configure Agent Delegation

Note which engine specialist agents to use (from hm-game-studio/agents/):
- Godot: godot-specialist, godot-gdscript, godot-shader, godot-gdextension
- Unity: unity-specialist, unity-dots, unity-shader, unity-addressables, unity-ui
- Unreal: unreal-specialist, ue-gas, ue-blueprint, ue-replication, ue-umg
- Custom: use generalist agents only

---

Phase 9: Post-Checks

- All fields in technical-preferences.md are filled (no [TO BE CONFIGURED] placeholders)
- Engine version is specific (not "latest" or "any")
- Post-cutoff warning exists if applicable
- Performance budgets match target platform
- Ask: "Ready to start designing systems?"

---

Edge Cases

- No engine installed on this machine: "Can't verify engine specifics. Fill in what we can theoretically, confirm when you have the engine installed."
- User doesn't know version: "Check the project files or the engine's About dialog. I can't proceed without an exact version."
- Multiple engines (hybrid project): "Pick one primary engine for this configuration. Secondary engine config goes in a separate file."
- No game project directory yet: Create it. "Where should I create the project?"
