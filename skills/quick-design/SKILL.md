name: quick-design
description: Lightweight spec for small, scoped design changes that don't warrant a full 8-section GDD. Defines: what changed, before/after values, rationale, affected systems, verification steps. Writes to design/quick-specs/[slug].md.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: game-designer

Quick Design — Lightweight Change Specification

For small, scoped changes — NOT for new systems or major rewrites. If the change touches more than 2 systems or takes more than 15 minutes to explain, use design-system instead.

Appropriate uses:
- Adjusting a tuning parameter
- Minor behavior tweak (e.g., "plants also grow in winter")
- UI text or layout change
- Bug fix specification

Inappropriate uses:
- New system design (use design-system)
- Cross-system rearchitecture (use architecture-decision + design-system)
- Anything requiring formulas (use design-system)

Output: design/quick-specs/[slug].md

---

Phase 1: Classify the Change

Ask: "What's changing and why?"
If the user gives a short answer (1-2 sentences): accept it.
If the user starts describing a complex system change: "This sounds like it needs a full GDD. Switch to design-system?"

Classify:
- Tuning change: value adjustment only → simplest path
- Behavior tweak: minor rule change → moderate path
- Bug fix specification: documenting intended behavior → clear path

---

Phase 2: Before/After Definition

For tuning changes:
- "What's the current value? What should it be?"
- Record: parameter name, file path, current value, new value, reason

For behavior tweaks:
- "What does the system do now? What should it do instead?"
- Record: current behavior, target behavior, one edge case

For bug fixes:
- "What's the current broken behavior? What's the correct behavior?"
- Record: bug report number (if exists), current broken behavior, target behavior

---

Phase 3: Impact Check

Ask: "Does this change affect any other system?"
Check the systems-index.md for dependencies.
If the changed system has dependents: "This system is used by [list]. Should those systems be reviewed too?"

If "no": note "No cascading impact — scoped change."
If "yes": list affected systems and what might need updating.

---

Phase 4: Verification

Ask: "How do we verify this change is correct?"
Good verification: "Run the game, check that the plant grows at the new rate."
Bad verification: "It should feel better."

Record the verification steps in the spec.

---

Phase 5: Write Spec

Write to design/quick-specs/[slug].md:

```
# Quick Spec: [Title]

**Date:** [YYYY-MM-DD]
**Author:** [user or system]
**Type:** Tuning / Behavior / Bug Fix

## Change
[What changed and why]

## Before
[Current behavior, value, or state]

## After
[Target behavior, value, or state]

## Rationale
[Why this change is needed]

## Impact
- Affected systems: [list or "None — scoped change"]
- Files to change: [list]

## Verification
[Steps to confirm the change works correctly]
```

---

Phase 6: Implement

Ask: "Should I apply this change now?"
If yes: update the affected files using patch or write_file.
If no: leave the spec as documentation. "The spec is saved. Implement when ready."

---

Edge Cases

- User wants to make 5 quick changes: "That's 5 changes, not one. Let's do them one at a time."
- Quick spec reveals deeper issue: "This change exposes a larger design gap. Consider a full GDD for [system]."
- Change affects a system with no tests: Note: "No tests for this system. Verify manually."
name: quick-design
description: Lightweight spec for small, scoped design changes that don't warrant a full 8-section GDD. Defines: what changed, before/after values, rationale, affected systems, verification steps. Writes to design/quick-specs/[slug].md.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: game-designer

Quick Design — Lightweight Change Specification

For small, scoped changes — NOT for new systems or major rewrites. If the change touches more than 2 systems or takes more than 15 minutes to explain, use design-system instead.

Appropriate uses:
- Adjusting a tuning parameter
- Minor behavior tweak (e.g., "plants also grow in winter")
- UI text or layout change
- Bug fix specification

Inappropriate uses:
- New system design (use design-system)
- Cross-system rearchitecture (use architecture-decision + design-system)
- Anything requiring formulas (use design-system)

Output: design/quick-specs/[slug].md


---

Phase 7: Approval and Handoff

After writing the spec:
- Ask: "Who needs to approve this change?"
- If the user is the approver: "Consider it approved. Ready to implement."
- If someone else: "Tag [person] to review this spec before implementation."

If implementation was requested:
- Apply the change using patch or write_file
- Verify the change works (run the game or test)
- If the change affects config data: "Config updated. Run balance-check to verify the new value is in range."

---

Phase 8: Documentation Update

After implementation:
- If a config value changed: update the relevant GDD's Tuning Knobs section if the range shifted
- If a behavior changed: add a note to the GDD's Edge Cases section if applicable
- If a bug was fixed: update the bug report status to "Fixed"

---

Edge Cases

- User asks for quick change but can't describe what they want: "Let's think about it together. What's the problem you're trying to solve?"
- Change needs UI mockup: "This needs a UX spec, not a quick design. Switch to ux-design?"
- User makes 10 quick changes in one session: "Let's batch these into a quick-spec document with all 10 changes. One file, clearly listed."
- Quick spec contradicts a GDD: Note the contradiction. "This quick spec changes [behavior] which is defined in [GDD]. The GDD should be updated to match."
