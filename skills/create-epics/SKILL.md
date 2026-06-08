name: create-epics
description: Translate GDDs and ADRs into epics — one per architectural module. Groups related systems from the systems index, identifies cross-epic dependencies, assigns layers and priorities. Each epic gets a file with scope, dependencies, and contained systems.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: systems-designer

Create Epics — Architectural Module Definition

Organizes related game systems into architectural modules (epics). Each epic represents a coherent unit of work that can be planned, estimated, and tracked independently.

Output: production/epics/[slug]/EPIC.md — one per epic

---

Phase 1: Read Context

Read design/gdd/systems-index.md for the complete system list with dependencies and priorities.
Read all GDDs in design/gdd/ for system-specific context.
Read all ADRs in docs/architecture/ for architectural constraints.

---

Phase 2: Group Systems into Modules

Examine the systems index. Group related systems:

Common module groupings:
- Core Engine: Day Manager, Scene Manager, Save/Load, Input
- Gameplay: Garden System, Interaction System, Crafting
- Content: Letter/Journal System, Narrative Events
- UI: HUD, Menus, Settings, Accessibility
- Audio: Music, SFX, Ambient
- Art: (not a coding epic but asset production epic)

Grouping heuristics:
- Systems that share data → belong together
- Systems that call each other frequently → belong together
- Systems that are independent → CAN be separate or combined (decide based on complexity)
- Systems that are very small (1-2 files) → combine with related systems

For each group, create an epic:
- Assign a short slug: "core-engine", "gameplay", "content", "ui"
- Write a description: what does this epic encompass?
- List the systems it contains (with GDD references)

---

Phase 3: Define Epic Dependencies

For each epic, determine what other epics it depends on:
- If Epic A contains a system that depends on a system in Epic B → A depends on B
- If no systems cross epic boundaries → epic is independent

Example:
- Content Epic depends on Gameplay Epic (letters reference garden state)
- UI Epic depends on Core Engine (settings screen needs save/load)
- Gameplay Epic depends on Core Engine (garden needs day calculation)

Write dependencies clearly: "Depends on: gameplay, core-engine"

---

Phase 4: Assign Layers and Priorities

Layer mapping from systems-index:
- If epic contains Foundation systems → Foundation layer
- If epic contains Core systems → Core layer
- Mixed: use the LAYER of the PRIMARY system in that epic

Priority: use the HIGHEST priority system in the epic:
- If any system is MVP → epic is MVP
- If no MVP but some Alpha → epic is Alpha
- Otherwise → Full Vision

---

Phase 5: Write Epic Files

For each epic, write to production/epics/[slug]/EPIC.md:

```
# Epic: [Name]

**Slug:** [slug]
**Layer:** Foundation / Core / Extended / Meta
**Priority:** MVP / Alpha / Full Vision

## Description
[One paragraph describing the epic's purpose and scope]

## Systems Included
- [System 1] — design/gdd/system1.md — [brief description]
- [System 2] — design/gdd/system2.md — [brief description]

## Dependencies
- [ ] [epic-slug-1] — [description of dependency]
- [ ] [epic-slug-2] — [description of dependency]

## ADR References
- ADR-[N] — [title]
- ADR-[M] — [title]

## Stories
[To be filled by create-stories]
- [ ] story-[name]
- [ ] story-[name]
```

---

Phase 6: Validate

Check:
- Every system from systems-index.md is assigned to exactly one epic
- Every epic dependency is valid (the depended-on epic exists)
- No circular epic dependencies: Epic A → Epic B → Epic A
- MVP systems are in MVP epics (not deferred to Alpha/Full epics)

If any system is unassigned: "System [X] isn't in any epic. Which epic does it belong to?"
If any epic is empty: "Epic [slug] has no systems. Remove it."

---

Phase 7: Post-Checks

- All epics written to production/epics/[slug]/EPIC.md
- Systems index can be cross-referenced to epics (every system → one epic)
- Epic dependencies form a DAG (no cycles)
- Presentation ready: "Created [N] epics: [list]. They're ready for story creation."

---

Phase 8: Epic Sizing

Once all epics are defined, estimate each epic's relative size:
- S: 1-3 stories, simple implementation, few files
- M: 4-8 stories, moderate complexity, multiple files
- L: 9-15 stories, significant complexity, may span multiple sprints
- XL: 16+ stories, major system, likely spans multiple milestones

Guidelines:
- If ALL epics are XL: the grouping is too coarse. Split.
- If ALL epics are S: the grouping is too fine. Merge.
- Aim for: 1-2 L, 3-4 M, rest S.

Epic sizing helps with: sprint planning, milestone estimation, resource allocation.

---

Phase 9: Cross-Epic Interface Definition

For each epic dependency, briefly note the interface between them:
- "Core Engine exposes: DayManager.current_date (Dictionary), DayManager.day_changed (signal)"
- "Gameplay consumes: DayManager.current_date, writes: GardenState.growth_stage (int)"

This isn't a full API spec — just enough to detect interface conflicts early.
If two epics disagree on an interface (one expects string, other expects int): flag now, not during implementation.

---

Edge Cases

- Only one epic (very small game): Acceptable. "Single epic game. Skip cross-epic interface tracking."
- Epics don't align with team structure: "Epics should match how you think about the work. Regroup if needed."
- GDD doesn't exist for a system in the epic: Flag as GAP. "System [X] in epic [Y] doesn't have a GDD yet. Create it before writing stories."
