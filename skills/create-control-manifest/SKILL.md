name: create-control-manifest
description: Create flat programmer rules sheet from GDDs and ADRs. Required patterns (from GDD Tuning Knobs), forbidden patterns (from ADR consequences), guardrails per layer (foundation/gameplay/UI/data). Includes date-stamped manifest version for staleness checking.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: lead-programmer

Create Control Manifest — Programmer Rules Reference

Creates a flat, checkable list of programming rules extracted from GDDs and ADRs.
Every story references the manifest version. Story-done checks for staleness.

Output: docs/architecture/control-manifest.md

---

Phase 1: Extract Rules from GDDs

Read each MVP GDD. For each, extract:

From Tuning Knobs section:
- "All values in [parameter list] must come from config files"
- This becomes a REQUIRED pattern

From Detailed Rules section:
- "The system MUST handle edge case [X]" → REQUIRED pattern
- "The system MUST NOT do [Y]" → FORBIDDEN pattern

From Formulas section:
- "Use formula [Z] exactly as specified" → REQUIRED pattern

From Edge Cases section:
- "If [edge case], code MUST [behavior]" → REQUIRED pattern

---

Phase 2: Extract Rules from ADRs

Read each Accepted ADR. For each, extract:

From Decision section:
- "The project uses [pattern/technology]" → REQUIRED pattern
- "The project does NOT use [alternative]" → FORBIDDEN pattern

From Consequences section:
- "We accept [tradeoff]" → ADVISORY note
- "This means [restriction]" → REQUIRED pattern

---

Phase 3: Define Per-Layer Rules

Layer hierarchy:
- Foundation (core/engine): Performance-critical. No allocations in hot paths. Thread safety for shared state.
- Gameplay: Data-driven design. No hardcoded values. Events over direct coupling. State machines for complex behavior.
- UI: No game state ownership. Localization-ready. Keyboard navigable. Responsive layout.
- AI: Performance budget per frame. Debug visualization required. Data-driven parameters.
- Data: JSON format. Versioned schema. All fields documented.
- Tests: Arrange-Act-Assert pattern. Independent test execution. One behavior per test.

For each layer, add project-specific rules extracted from Phases 1-2.

---

Phase 4: Write Manifest

Write to docs/architecture/control-manifest.md:

```
# Control Manifest

**Manifest Version:** [YYYY-MM-DD-v1]

## Required Patterns
- [Pattern] — Source: [GDD/ADR reference] — Layer: [layer]
- [Pattern] — Source: [GDD/ADR reference] — Layer: [layer]

## Forbidden Patterns
- [Pattern] — Source: [GDD/ADR reference] — Layer: [layer]
- [Pattern] — Source: [GDD/ADR reference] — Layer: [layer]

## Guardrails by Layer

### Foundation
- DO: ...
- DON'T: ...

### Gameplay
- DO: ...
- DON'T: ...

### UI
- DO: ...
- DON'T: ...

### Data
- DO: ...
- DON'T: ...
```

The Manifest Version is a date stamp plus version number. It's used by story-done to check if stories reference an outdated manifest.

---

Phase 5: Post-Checks

- Manifest has at least: 3 Required patterns, 3 Forbidden patterns, per-layer guardrails
- Every pattern has a source reference (which GDD or ADR it came from)
- Manifest Version stamp is in the header
- Ask: "Control manifest created. Stories will now reference this version for staleness checks."

---

Phase 6: Project-Specific Rules

Add any project-specific rules the user provides:
- "We use [library]" → Allowed Libraries section
- "We never use [pattern]" → Forbidden Patterns section
- "All [type] must go through [system]" → Required Patterns section

Ask: "Any project-specific rules I should add?"
If yes: add them to the appropriate section.

---

Phase 7: Manifest Staleness Detection

The manifest version stamp enables story-done to detect staleness:
- Every story references "Manifest Version: [date]"
- When the manifest is updated (new rules added), the version stamp changes
- story-done checks: does the story's manifest version match the current one?
- If not: "Story references manifest v[old], current is v[new]. Check for newly added rules."

Without a version stamp, this check is impossible. The stamp MUST be in the header.

---

Phase 8: Post-Write Verification

After writing the manifest:
- Count: Required patterns [N], Forbidden patterns [N], Per-layer sections [N]
- If <3 Required patterns: "Very few required rules. The manifest may be incomplete."
- If <3 Forbidden patterns: "Very few forbidden rules. Consider adding ADR-derived rules."
- Every rule has a source GDD or ADR. If any rule has "Custom" as source, flag for user review.

---

Edge Cases

- No GDDs or ADRs to extract from: "No design or architecture docs yet. The manifest will start empty and grow as GDDs and ADRs are created."
- All rules are from user preference (not from docs): "These are good conventions, but they're not enforced by design docs. Consider adding them to the relevant GDDs."
- Manifest becomes very long (>20 rules): "The manifest has [N] rules. If every rule is important, keep them. If some are obvious, remove them. Too many rules → none get followed."
