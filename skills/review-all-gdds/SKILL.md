name: review-all-gdds
description: Cross-GDD consistency review after all MVP GDDs are created. Checks: dependency bidirectionality, rule contradictions, formula range compatibility, naming consistency, design theory issues (competing loops, cognitive load, dominant strategies).
allowed-tools: read_file, search_files, write_file, clarify
model: sonnet
agent: game-designer

Review All GDDs — Cross-System Consistency

Reviews every GDD together as a whole to find issues that individual reviews miss. This is the second pass — individual GDDs should already be approved by design-review before this runs.

Output: design/gdd/cross-review-[date].md

---

Pre-Checks

If fewer than 2 GDDs exist: "Need at least 2 GDDs to cross-review. Create more systems first."
If any GDD status is "Not Started" or "In Design": "Some GDDs aren't ready for review. Complete them first."

---

Phase 1: Collect All GDDs

Search design/gdd/*.md.
Exclude: game-concept.md, systems-index.md.
For each GDD found: read the entire file.

Record for each GDD:
- System name and slug
- All rules from Detailed Rules section
- All formulas from Formulas section
- All dependencies from Dependencies section
- All tuning ranges from Tuning Knobs section
- All edge cases from Edge Cases section

---

Phase 2: Dependency Bidirectionality

For each dependency declared in each GDD:
- Find the depended-upon GDD
- Does it list THIS system as a dependent?
- If not: MISSING BIDIRECTIONAL REFERENCE

Example:
- Garden GDD: "Depends on: Day Manager"
- Day Manager GDD: does it say "Used by: Garden System"?
- If not: "Day Manager GDD doesn't list Garden System as a dependent. Add it."

This is MEDIUM severity — doesn't break functionality, but the dependency map becomes unreliable.

---

Phase 3: Rule Contradictions

Compare every rule from every GDD against every other GDD:
- "GDD-A says X. GDD-B says not-X."
- If found: CONTRADICTION — must be resolved

Common contradiction patterns:
- Same parameter, different range: "GDD-A says max_health=100, GDD-B says max_health=50"
- Same behavior, different trigger: "GDD-A says plants grow at midnight, GDD-B says plants grow at dawn"
- Same constraint, different values: "GDD-A says garden fits 10 plants, GDD-B says player can plant 20"

Each contradiction gets: the two GDDs involved, the specific statements that conflict, which one is likely correct (if determinable).

---

Phase 4: Formula Range Compatibility

For formulas that interact across systems:
- GDD-A produces value X in range [1-100]
- GDD-B takes value Y in range [1-10]
- Does GDD-B normalize or scale GDD-A's output?
- If GDD-B just uses GDD-A's value directly: "GDD-B's input range [1-10] doesn't match GDD-A's output range [1-100]. Values will be out of spec."

This is HIGH severity — will cause invisible math errors during gameplay.

---

Phase 5: Naming Consistency

Check: do different GDDs use different names for the SAME concept?
- GDD-A: "watering_can" / GDD-B: "watercan" / GDD-C: "can" → INCONSISTENT
- GDD-A: "health" / GDD-B: "hp" / GDD-C: "hit_points" → INCONSISTENT

Cross-reference with systems-index.md: do the slugs match the GDD filenames?
- systems-index says "garden-state" but file is "gardening.md" → FILENAME MISMATCH

---

Phase 6: Design Theory Checks

6a. Competing progression loops
Check: do two different systems compete for the SAME player action?
- "Both the garden and the crafting system require the player to click the same button" → COMPETING
- "The garden needs daily attention, but letters also need daily attention" → COMPETING

6b. Cognitive load
Count: how many systems are active at the same time?
"At any given moment, the player manages: garden (3 sub-systems) + letters (1) + pets (2) + weather (1) = 7 active systems."
Max recommended: 4 active systems. If >4: "Too many concurrent systems. Consider simplifying or staggering unlocks."

6c. Dominant strategies
Check: is there ONE approach that's always best?
- "The most expensive plant is always the best investment" → DOMINANT STRATEGY
- "Watering every day is strictly better than any other pattern" → DOMINANT STRATEGY
Mark as DESIGN CONCERN — may reduce player choice to illusion.

---

Phase 7: Write Report

Write to design/gdd/cross-review-[date].md:

```
# Cross-GDD Review: [date]

**GDDs reviewed:** [list]

## Bidirectionality
- Missing references: [N] — [list]
- CORRECT: all dependencies are bidirectional

## Contradictions
- BLOCKING: [N] — [list contradictions]
- Non-blocking: [N]

## Formula Compatibility
- Compatible: all formulas work together
- GAPS: [N] — [list range mismatches]

## Naming
- Consistent: all names match across GDDs
- INCONSISTENT: [list naming issues]

## Design Theory
- Competing loops: [none / list]
- Cognitive load: [acceptable / HIGH — reduce to 4]
- Dominant strategies: [none / list]

## Verdict
PASS: All checks clear. GDDs are consistent.
CONCERNS: [issues to address before implementation]
FAIL: [blocking issues — must fix]
```

---

Phase 8: Post-Checks

- Report written to design/gdd/
- If FAIL: list exactly which GDDs need changes and what to change
- If PASS: "Cross-GDD review passed. Ready for Phase 3 (Technical Setup)."
