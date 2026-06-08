name: design-review
description: Reviews a GDD for completeness (all 8 sections present with substantive content), pillar alignment, consistency, testability, and feasibility. Returns APPROVED / CHANGES REQUESTED / REJECTED. In full mode, delegates to creative-director for pillar alignment review.
allowed-tools: read_file, search_files, clarify, delegate_task
model: sonnet
agent: game-designer

Design Review — GDD Quality Gate

Reviews a Game Design Document for completeness, quality, and alignment with the game's pillars.
This is a READ-ONLY skill — it does not modify the GDD.

Output: review verdict (APPROVED / CHANGES REQUESTED / REJECTED) and notes.

---

Pre-Checks

Verify: the GDD file exists at the specified path.
If the user didn't specify a GDD: search design/gdd/*.md, list available GDDs, ask which to review.
If no GDDs exist: "No GDDs found. Run design-system first."

---

Phase 1: Load Context

Read the GDD being reviewed.
Read design/gdd/game-concept.md for pillars (to check alignment).
Read design/gdd/systems-index.md for system dependencies (to check accuracy).
Read hm-game-studio/rules/design-docs.md for format standards.

Phase 2: Check Completeness (8 Sections)

Scan the GDD for all 8 required sections:

| Section | Heading to find | Is content substantive? |
|---|---|---|
| 1. Overview | ## 1. Overview or ## Overview | Must describe the system's PURPOSE, not just list features |
| 2. Player Fantasy | ## 2. Player Fantasy or ## Player Fantasy | Must describe an EMOTION, not a mechanic |
| 3. Detailed Rules | ## 3. Detailed Rules or ## Detailed Rules | Must be UNAMBIGUOUS — another dev could implement from these |
| 4. Formulas | ## 4. Formulas or ## Formulas | Must have VARIABLES with ranges, not just a final number |
| 5. Edge Cases | ## 5. Edge Cases or ## Edge Cases | Must be SPECIFIC situations, not "handle gracefully" |
| 6. Dependencies | ## 6. Dependencies or ## Dependencies | Must be BIDIRECTIONAL (A→B, B→A) |
| 7. Tuning Knobs | ## 7. Tuning Knobs or ## Tuning Knobs | Must have DEFAULTS, RANGES, and CONFIG FILE paths |
| 8. Acceptance Criteria | ## 8. Acceptance Criteria or ## Acceptance Criteria | Must be TESTABLE (PASS/FAIL), not subjective |

For each section:
- MISSING: Section heading not found
- PLACEHOLDER: Section exists but content is "[To be designed]" or equivalent
- SUBSTANTIVE: Section has real content

A GDD with any MISSING sections: CHANGES REQUESTED.
A GDD with any PLACEHOLDER sections: CHANGES REQUESTED (flag the specific sections).

Phase 3: Quality Check

For each substantive section, assess depth:

3a. Overview
- Does it describe the system's purpose in one paragraph?
- Does it avoid implementation details? ("The player grows plants by watering them daily" ✓ vs "A GardenManager singleton with a growth_timer signal" ✗)
- Can a new team member read this and understand what the system is for?

3b. Player Fantasy
- Is it an emotion, not a mechanic? ("Player feels pride in their growing garden" ✓ vs "Player can water plants" ✗)
- Does it connect to the game's pillars? (Reference the pillar it serves)

3c. Detailed Rules
- Are the rules unambiguous? ("Plants grow one stage every 7 days, measured at the start of each day" ✓ vs "Plants grow over time" ✗)
- Are exceptions explicitly stated? ("All plants follow this EXCEPT cacti, which ignore season penalties")
- Are there numbered lists or bullet points for clarity?

3d. Formulas
- Are all variables defined with ranges? (growth_rate = 1.0 [range: 0.1-5.0])
- Is there an example calculation? (e.g., "If a plant has growth_rate=2.0 and it's spring, actual=3.0")
- Are boundary conditions specified? (What happens at min/max values?)

3e. Edge Cases
- Are the edge cases SPECIFIC, not generic? ("Player doesn't water for 30 days → garden enters dormancy" ✓ vs "Handle errors gracefully" ✗)
- Is there at least 1 edge case per system rule?
- Are the edge cases about player behavior, data corruption, and system interaction?

3f. Dependencies
- Are dependencies BIDIRECTIONAL? (GDD-A lists B as dependency, B lists A as dependent?)
- Cross-check with systems-index.md: do the listed dependencies match?
- Cross-check with other GDDs: if GDD-A says "depends on B", does B's GDD list A?

3g. Tuning Knobs
- Does each knob have: default, range, step, config file path?
- Example: "growth_stage_days: default=7, range=3-21, step=1, source=assets/data/garden.json"
- If any knob says "should never change": push back. Move to config, it's safer.

3h. Acceptance Criteria
- Is each criterion TESTABLE? (Can you write a test or manual check?)
- Are they categorized? (AUTO / MANUAL / DEFERRED — see design-system skill)
- Is there at least one auto-checkable criterion? (For CI/CD)
- Minimum 3 criteria? 5+ is better.

Phase 4: Pillar Alignment

Read the game pillars from game-concept.md.
For each pillar: does the GDD serve it?

Example:
- Pillar: "Effortless Calm — no timers, no fail states"
- GDD rule: "Plants grow automatically, player can optionally water them"
- Alignment: ✅ Player can't fail. No pressure. Aligned.
- GDD rule: "Plants die if not watered for 3 days"
- Alignment: ❌ Adds pressure. Contradicts the pillar.

If review mode is "full": delegate to creative-director for a thorough pillar alignment check.
Context: the GDD path, the game pillars, the MDA aesthetic targets.

Phase 5: Consistency Check

Compare this GDD against other existing GDDs for the same project:

5a. Formula range compatibility
- If GDD-A outputs value range [1-100] and this GDD takes input in range [1-10]
- Does this GDD normalize the input? If not: INCOMPATIBLE RANGES

5b. Rule contradictions
- Check for statements that contradict other GDDs
- Example: Gardening GDD says "plants grow in all seasons" but Weather GDD says "plants don't grow in winter"

5c. Naming consistency
- Do system names match across GDDs?
- Do variable names follow the same convention?

Phase 6: Feasibility Check

Assess whether the GDD describes something implementable:

- Is there a known engine technique for what's described? (If not, flag as technical risk.)
- Is the scope appropriate for the project's stage? (If Phase 2 and the GDD describes systems that won't be built for 6 months, flag as FUTURE SCOPE.)
- Does the GDD assume technology not yet decided? (If it says "use Unity DOTS" but engine is Godot, flag as ENGINE MISMATCH.)

Phase 7: Determine Verdict

| Verdict | Criteria | Action |
|---|---|---|
| APPROVED | All sections present, substantive, aligned, consistent, feasible | Update GDD status to "Approved" |
| CHANGES REQUESTED | Missing/placeholder sections, minor inconsistencies | List specific issues. Update status to "Needs Revision" |
| REJECTED | Major contradictions, unfeasible, violates pillars | List blocking issues. Do not proceed. |

Phase 8: Report

Present the review:

```
## Design Review: [GDD name]

### Completeness
- [✅/❌] Overview — [note]
- [✅/❌] Player Fantasy — [note]
- [✅/❌] Detailed Rules — [note]
- [✅/❌] Formulas — [note]
- [✅/❌] Edge Cases — [note]
- [✅/❌] Dependencies — [note]
- [✅/❌] Tuning Knobs — [note]
- [✅/❌] Acceptance Criteria — [note]

### Quality Concerns
[Issues found in each section]

### Pillar Alignment
[Pillar 1]: [ALIGNED / CONFLICT] — [note]
[Pillar 2]: [ALIGNED / CONFLICT] — [note]

### Verdict: [APPROVED / CHANGES REQUESTED / REJECTED]
```

Phase 9: Post-Review Action

Update the GDD's Status field:
- APPROVED → "Approved"
- CHANGES REQUESTED → "Needs Revision"
- REJECTED → "Needs Revision"

If CHANGES REQUESTED or REJECTED: "Would you like me to fix the identified issues now?"
If yes: use design-system with retrofit mode to fix the specific sections.
