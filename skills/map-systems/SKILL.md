name: map-systems
description: Create or update design/gdd/systems-index.md — enumerates all game systems, maps bidirectional dependencies between them, assigns each to a design layer (Foundation/Core/Feature/Presentation/Polish) and priority tier (MVP/Alpha/Full Vision). Ensures no circular dependencies and correct design ordering.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: game-designer

Map Systems — System Architecture Index

Creates or updates the systems index document — the single source of truth for what systems the game has, how they depend on each other, and in what order they should be designed and built.

Output: design/gdd/systems-index.md

---

Pre-Checks

If design/gdd/game-concept.md doesn't exist: "No concept document found. Run brainstorm or start first."
If systems-index.md already exists: "Systems index already exists. Should I update it or overwrite?"
Options: "Update existing (preserve existing entries)" / "Start fresh" / "Cancel"

---

Step 1: Brainstorm System List

Ask the user: "What systems does this game need to function?"

Guide with categories (read them one at a time, not as a block):
- Foundation: Date/time, save/load, scene management, input handling
- Core: Player mechanics, interaction, core progression, primary verbs
- Feature: Secondary mechanics, economy, crafting, dialogue, AI
- Presentation: Audio, VFX, UI, camera, animations
- Polish: Settings, accessibility, analytics, notifications

For each category, ask: "Any systems in this category?"
Prompt with examples from the game concept's core loop.
If the concept involves gardening: "Your core loop mentions planting → watering → growing. That suggests: Garden State, Interaction System, Day Manager, Scene Renderer."

List each system the user confirms. Give each a short slug: "Day Manager" → day-manager.

Continue until the user says "that's all." Aim for 5-15 systems. Fewer than 5 means something's probably missing.

---

Step 2: Map Dependencies

For each system, ask: "What does [system] need to work?"
Record each dependency.

Then, flip it: for each system, check if it's listed as a dependency by any OTHER system.
This builds the bidirectional dependency graph.

Example:
- Day Manager: no dependencies (root system)
- Garden State: depends on Day Manager (needs to know what day it is)
- Letter System: depends on Day Manager + Garden State (needs date + garden conditions)
- Scene Renderer: depends on Day Manager

Visual representation:
```
Day Manager ──→ Garden State
     │               │
     │               │
     ▼               ▼
Scene Renderer    Letter System
```

Check for circular dependencies:
- If A→B and B→A: "Circular dependency detected between [A] and [B]. One of these dependencies is wrong."
- Request: "Which direction is correct?"

---

Step 3: Assign Layers

Explain the layer system:
| Layer | Contains | Design priority |
|---|---|---|
| Foundation | Systems nothing else depends on | Design FIRST |
| Core | Primary gameplay mechanics | Design SECOND |
| Feature | Secondary systems | Design THIRD |
| Presentation | UI, audio, VFX | Design FOURTH |
| Polish | Settings, accessibility | Design LAST |

For each system, ask: "Which layer does [system] belong to?"
Default assignment based on dependencies:
- If nothing depends on it → Foundation
- If it's part of the core loop → Core
- If it enriches but isn't required → Feature
- If it's about how things look/sound → Presentation
- If it's about player comfort → Polish

---

Step 4: Assign Priorities

Explain the priority system:
| Priority | Meaning | When to build |
|---|---|---|
| MVP | Must ship | First |
| Alpha | Important but not blocking | After MVP |
| Full Vision | Nice to have | Post-launch |

Guide: "What's the absolute minimum to deliver the core fantasy?"
- Everything in the core loop → MVP
- Everything that makes it better but isn't required → Alpha
- Everything that's a stretch goal → Full Vision

Aim for: 60% MVP, 25% Alpha, 15% Full Vision. 
If >80% MVP: "Almost everything is MVP — you may be underestimating scope. Can anything be deferred?"
If <30% MVP: "Very few MVP items — the core loop may be too thin. What's the minimum playable game?"

---

Step 5: Write Systems Index

Write to design/gdd/systems-index.md:

```
# Systems Index: [Game Name]

## System Registry

| # | System | Slug | Layer | Priority | Status | Dependencies |
|---|---|---|---|---|---|---|
| 1 | Day Manager | day-manager | Foundation | MVP | Not Started | — |
| 2 | Garden State | garden-state | Core | MVP | Not Started | Day Manager |
| 3 | Letter System | letter-system | Feature | Alpha | Not Started | Day Manager, Garden State |

## Dependency Graph

```
[ASCII art representation — use the same format as the visual above]
```

## Design Order

1. Foundation: [list]
2. Core: [list]
3. Feature: [list]
4. Presentation: [list]
5. Polish: [list]
```

---

Step 6: Post-Checks

- Every system has exactly one layer and one priority
- No circular dependencies in the graph
- Dependency direction is correct (root systems first)
- The combined MVP systems are sufficient to deliver the core fantasy
- Write to file. Get approval before final write.

---

Edge Cases

- User lists 20+ systems: "20+ systems is a lot for an indie project. Are any of these really the same system? Can any be deferred past MVP?"
- User can't define dependencies: "Think about it this way: if system A is a separate file from system B, and A uses data from B, then A depends on B."
- Single-system game (e.g., a simple clicker): Still needs foundation systems (save, input, scene). List them.
- User forgot a critical system: If the core loop implies it but it's not listed, ask: "Your core loop mentions [X] — shouldn't there be a system for that?"
