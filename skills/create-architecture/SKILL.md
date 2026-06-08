name: create-architecture
description: Create the master architecture document — system boundaries and responsibilities, data flow between systems, integration points, engine alignment patterns. Reads GDDs, ADRs, and systems-index to produce a single reference for how systems connect.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: lead-programmer

Create Architecture — System Architecture Definition

Creates the project's architecture document — the single source of truth for how systems are organized, how they communicate, and how they map to the engine.

This is the document that answers: "If I want to add a new feature, where does it go and what does it talk to?"

Output: docs/architecture/architecture.md

---

Phase 1: Read Context

Read design/gdd/systems-index.md for the complete system list, dependencies, and layers.
Read all Accepted ADRs in docs/architecture/ for architecture decisions.
Read all GDDs for system-specific interface details.
Read docs/technical-preferences.md for engine and naming conventions.

---

Phase 2: Define System Boundaries

For each MVP system from the index, define:
- What data does this system OWN? (The system is the single source of truth for this data.)
- What does this system EXPOSE? (Public API: functions, signals, events, properties.)
- What does this system CONSUME? (Other systems' APIs that it calls.)

Format:
| System | Owns | Exposes | Consumes |
|--------|------|---------|----------|
| DayManager | current_date, season, save_data | day_changed, season_changed signals | Nothing (root) |
| GardenState | growth_stage, plant_list | plant_data for rendering | DayManager.current_date |
| SceneRenderer | visual scene, animations | render commands | GardenState.plant_data |

If a system doesn't have a clear ownership boundary: flag it. "System [X] doesn't have clear data ownership. This will cause coupling issues."

---

Phase 3: Define Data Flow

For each pair of systems that communicate:
- Direction: A → B? Bidirectional? Event-based?
- Mechanism: signal/event, direct function call, shared data store, message queue?
- Frequency: per frame, per second, on demand, on state change?

Format:
```
DayManager ──(signal: day_changed)──→ GardenState
DayManager ──(signal: day_changed)──→ SceneRenderer
GardenState ──(property: plant_data)──→ SceneRenderer (read-only)
```

Rule: events/signals for one-to-many communication, direct calls for one-to-one, shared state only for performance-critical data.

---

Phase 4: Engine Alignment

Map each system to the engine's architectural patterns:

Godot:
- DayManager → Autoload (global singleton)
- GardenState → Autoload or Node (if needs scene tree)
- SceneRenderer → Main scene node
- UI → Control nodes, separate scene

Unity:
- DayManager → ScriptableObject (singleton via Resources)
- GardenState → MonoBehaviour on a GameObject
- SceneRenderer → Camera + Canvas + GameObjects
- UI → Canvas with child UI elements

Unreal:
- DayManager → GameInstance subsystem
- GardenState → Actor or ActorComponent
- SceneRenderer → Level + PlayerController
- UI → UMG Widgets

Document the mapping for each system.

---

Phase 5: Write Architecture Document

Write to docs/architecture/architecture.md:

```
# System Architecture: [Project]

**Last updated:** [date]

## Overview
[Brief summary of architecture approach — monolith? modular? ECS?]

## System Boundaries
[Table: System | Owns | Exposes | Consumes]

## Data Flow
[ASCII diagram or description of data movement between systems]

## Engine Pattern
[Table: System | Engine Type | Reason]

## Integration Points
[Where systems connect and how they communicate]

## Key Architecture Rules
- [Rule 1 from control manifest or ADRs]
- [Rule 2]
```

---

Phase 6: Post-Checks

- Every MVP system from systems-index is represented
- Every system boundary is clear (no "both own X" ambiguity)
- Data flow is directional (not "everyone talks to everyone")
- Engine patterns are realistic (not impossible in the chosen engine)
- Ask: "Architecture document created. Ready to move to technical setup?"

---

Phase 7: Architecture Review Triggers

Note when the architecture should be revisited:
- When a new system is added that doesn't fit existing boundaries
- When performance issues suggest a data flow problem
- When a new ADR changes fundamental architecture decisions

The architecture document is a LIVING document. Update it when systems change.

---

Phase 8: Anti-Patterns to Avoid

Based on analysis of the current design, flag common anti-patterns:
- God class: one system that owns too much data and too many responsibilities
  "System [X] owns [N] data types and exposes [M] API methods. Consider splitting."
- Circular dependency: two systems that depend on each other
  "System [A] and [B] have a circular dependency. Break it by introducing an interface or event."
- Shotgun surgery: one change that touches many systems
  "Adding a new [feature] requires changes to [N] systems. Consider consolidating related functionality."

---

Phase 9: Architecture Diagram

Create a text-based architecture diagram:

```
┌─────────────┐     ┌──────────────┐
│  DayManager  │────▶│  GardenState  │
│  (Autoload)  │     │  (Autoload)   │
└─────────────┘     └──────┬───────┘
                           │
                           ▼
                    ┌──────────────┐
                    │SceneRenderer │
                    │  (MainScene) │
                    └──────────────┘
```

This gives developers a quick visual reference for how systems connect.

---

Edge Cases

- Too many systems to diagram (>10): Group related systems. Diagram groups, not individuals.
- No engine pattern matches the system cleanly: Accept the closest match. Flag: "System [X] doesn't map cleanly to standard [engine] patterns. Custom implementation needed."
- Two systems claim ownership of the same data: Flag as conflict. "Both [A] and [B] claim to own [data]. Resolve ownership before implementation."
