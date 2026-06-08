name: skill-test
description: Test an HMGS framework skill for correctness. Walk through steps, verify output, report PASS/FAIL.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: qa-tester

Skill Test — Framework Quality Check

Tests that a framework skill produces correct results when followed.
Does not test the game — tests the framework itself.

---

Phase 1: Select Skill

Ask: "Which skill to test?"
Or if argument provided: test that skill.

Phase 2: Static Structure Check

Read the skill's SKILL.md.
Check:
- Has a clear name/description in first lines?
- Has pre-conditions section?
- Has numbered steps?
- Has output artifact defined?
- Has post-checks?
- Total lines: if < 40, flag as THIN

Phase 3: Simulate Run

Walk through each step. For each:
- Can the file operations be performed? (files exist, paths correct)
- Are the branching conditions covered? (if X then Y, else Z)
- Are edge cases handled?
- Does the step produce the expected output?

Phase 4: Report

PASS: All checks pass, skill is functional
FAIL: One or more checks fail — specific issues listed
NEEDS IMPROVEMENT: Skill works but is thin or missing detail

Phase 4: Behavioral Spec Test
If a test spec exists for the skill (in skill-testing/templates/):
- Read the spec
- For each step in the spec: simulate execution, check output
- Confirm: skill produces the expected output

Phase 5: Results
- Static checks: [N] passed, [N] failed
- Category checks: [N] passed, [N] failed
- Content review: [adequate / thin / missing]
- Verdict from behavioral spec: [PASS / FAIL]

Phase 6: Report
Write to skill-testing/results/[skill-name]-[date].md.

---

Phase 6: Improvement Recommendations

If verdict is NEEDS IMPROVEMENT:
- List specific, actionable recommendations:
  1. "Add pre-conditions section"
  2. "Expand Phase 2: add branching logic for when [condition]"
  3. "Add edge cases section with at least 3 specific scenarios"
- Estimate: "Estimated effort to fix: [5/15/30] minutes."

If verdict is FAIL:
- "This skill has fundamental issues. Recommended: rewrite using the design-system approach."
- Blocking issues: [list]

If verdict is PASS:
- "Skill meets quality standards."

---

Phase 7: Results Persistence

If the user requests it: write results to skill-testing/results/[name]-[date].md.
Keeps a historical record of skill quality over time.

---

Edge Cases

- Skill is brand new and very short: "New skills start thin. That's expected — improve over time through use."
- Testing requires running a game: "Can't run the game from here. Test documentation-based skills only. Game testing requires running the actual game."
- User disagrees with a FAIL verdict: "I'll note your override. The skill is marked as PASS by user decision."

---

Phase 8: Automated Testing

If the skill has a behavioral spec (in skill-testing/templates/):
- Read the spec
- Walk through each step
- Verify output matches expected
- Record result

---

Phase 9: Full Framework Audit

If asked to test ALL skills: "Testing all 74 skills will take significant time. I'll run static structure checks on all of them (fast) and full depth reviews on a subset."
Run static checks only: for each skill, check frontmatter + line count. Report summary.

---

Edge Cases

- Skill references an agent that doesn't exist: "Skill [name] references agent [X]. Check hm-game-studio/agents/ — agent [X] not found."
- Skill references a tool not in allowed-tools: "Skill [name] uses [tool] but allowed-tools doesn't list it."
- Skill is in a subcategory not in the rubric: "Category [name] isn't in the rubric. Add it or assign to an existing category."

---

Phase 12: Quality Gate Integration

If this is part of a release prep:
- "All framework skills should pass skill-test before a framework release."
- "Run: test all skills with category 'gate' and 'utility' first — those are most used."
- "Fix all FAIL before release. NEEDS IMPROVEMENT is acceptable if documented."

---

Phase 13: Self-Referential Check

After improving this skill, run skill-test on itself.
"Skill-improve improves other skills. Does it pass its own quality standards?"
If not: "Meta-issue: skill-improve doesn't meet the standards it enforces for other skills."
Fix skill-improve to meet its own standards, then continue.

---

Edge Cases (continued)

- All skills pass: "Framework quality is good. Run again after adding new skills or making significant changes to existing ones."
- Only one skill fails consistently: "That skill has systemic issues. Consider rewriting rather than patching."
- User wants to automate this: "Create a CI step: weekly, run skill-test on all skills. Report results."

---

Edge Cases (continued)

- Framework version mismatch: If this skill was written for an older version of HMGS, some quality criteria may not apply. Note the framework version and adjust expectations accordingly.
- Skill is intentionally minimal: Some skills don't need 200+ lines (e.g., simple helpers). If the skill does one thing well with 60 lines, that's acceptable for its category.
- User override: If the user explicitly says 'this is fine as-is,' respect that. Document the override reason.
