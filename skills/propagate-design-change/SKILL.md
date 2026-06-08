name: propagate-design-change
description: When a design change in one GDD affects downstream dependents, trace and update all affected documentation. Checks each dependent system's GDD for: formula references, interface expectations, dependency descriptions. Updates bidirectional references. Flags contradictions created by the change.
allowed-tools: read_file, write_file, patch, search_files, clarify
model: sonnet
agent: game-designer

Propagate Design Change — Impact Tracing

When a system's design changes, this skill finds all systems that depend on it and updates their documentation to match. Prevents the common problem of "we changed X but forgot to update Y and Z."

Output: updated GDDs, change propagation report

---

Phase 1: Identify the Change

Ask: "What exactly changed and in which GDD?"
Or read the file the user specifies.

Identify the type of change:
- Formula change: values, ranges, variables, or formula expression changed
- Rule change: behavior, constraints, or interactions changed
- Interface change: API, events, signals, or data format changed
- Tuning change: default value or range boundaries changed

For each change type, the propagation scope is different:
- Formula change: affects all dependents that USE the formula output
- Rule change: affects all dependents that RELY ON the behavior
- Interface change: affects ALL dependents (they must update their calls)
- Tuning change: affects downstream calculations (may need re-balancing)

---

Phase 2: Trace Downstream

From systems-index.md:
- Find all systems that depend on the changed system
- For each dependent, read its GDD
- Find EVERY reference to the changed system

For each reference, determine if it needs updating:
- References a changed formula → must update formula reference
- References a changed rule → must check if rule still makes sense
- References a changed interface → MUST update (will break if not)
- References unchanged behavior → no action needed

---

Phase 3: Update Documentation

For each affected GDD, make the specific updates:
- If formula changed: update the formula reference and any derived constants
- If rule changed: check for contradictions and update
- If interface changed: update API calls, parameter names, expected data format
- If dependency description changed: update the bidirectional reference

Use patch for targeted updates. Get approval per GDD before changing.

---

Phase 4: Flag Contradictions

After updates, check for remaining contradictions:
- "System A now outputs [range], but System B expects [different range]" → INCOMPATIBLE
- "System A now requires [input], but System B doesn't provide it" → MISSING DEPENDENCY
- "System A's new behavior conflicts with System B's rules" → CONTRADICTION

For each contradiction:
- Describe: what conflicts, which two systems, why it's a problem
- Severity: BLOCKING (will crash) / HIGH (will produce wrong results) / MEDIUM (will produce unexpected but non-critical results)

---

Phase 5: Report Changes

Present a change report:

```
## Change Propagation Report

**Source change:** [system] — [type of change]

### Files Updated
- [GDD path] — updated [section] — [what changed]

### Files Needing No Change
- [GDD path] — not affected (no reference to changed system)

### Contradictions
- BLOCKING: [contradiction description]
- HIGH: [description]
- MEDIUM: [description]

### Recommendation
- [If BLOCKING]: "Resolve contradictions before implementing."
- [If safe]: "All dependents updated. The change is now consistent across all documentation."
```

---

Phase 6: Update Systems Index

If the change affects the dependency relationships:
- Update systems-index.md: changed dependencies, added/removed systems, reordered layers
- "systems-index.md updated: [change]"

If the change doesn't affect dependencies:
- "No changes needed to systems-index.md — dependencies unchanged."

---

Phase 7: Verify Bidirectional References

After all updates:
- For each system A that depends on B: does B's GDD reference A back?
- Re-check the entire dependency graph
- If any unidirectional references remain: flag them

"After propagation: all dependencies are bidirectional. ✅"

---

Phase 8: Offer ADR Update

If the change is significant enough to affect architecture decisions:
- "This change may affect ADR-[N] which covers [topic]. Should I review and update it?"
- If yes: read the ADR, check if the decision/consequences need updating, use patch to update.

---

Edge Cases

- Change is so large it requires new GDDs: "This change affects more than 50% of [system]'s behavior. Consider a new GDD instead of patching the existing one."
- Dependent system doesn't have a GDD yet: "System [X] depends on [Y], but [Y] has no GDD. Can't propagate. Create [Y]'s GDD first."
- Change introduces circular dependency: "By changing [X], [Y] now depends on [X] which already depends on [Y]. Circular dependency detected. Resolve before proceeding."

Phase 9: Implementation Checklist

After all documentation is updated, create a quick implementation checklist:
- [ ] All GDDs updated with new values/interfaces
- [ ] Systems index dependencies updated (if applicable)
- [ ] ADRs reviewed for impact (if applicable)
- [ ] Downstream formulas re-verified for compatibility
- [ ] No contradictions remain across affected GDDs

This checklist ensures the propagation is complete before any code is written based on the change.

---

Phase 10: Notification

If this is a team project:
- "This change affects [N] systems designed by [potential owners]. They should be notified."
- List: "Systems affected: [list]. Designers to inform: [list]."
- If solo project: "No notification needed — you own all affected systems."

---

Edge Cases (continued)

- User can't remember what changed: "Let's diff the GDD. Read the current version. Compare with what you recall. What's different?"
- Change is reverted: "Undo propagation. Restore the original GDDs from git? git checkout -- [files]"
- Propagation creates more work than expected: "If the propagation effort is larger than the original change was worth, reconsider: is this change necessary?"
