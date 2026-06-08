name: skill-improve
description: Test → diagnose → propose fix → apply → retest loop for framework skills. Runs skill-test on the target, identifies specific failures, proposes targeted fixes, applies them, and retests until PASS. Logs improvement to skill-testing/results/.
allowed-tools: read_file, write_file, patch, clarify
model: sonnet
agent: qa-lead

Skill Improve — Framework Quality Iteration

Improves a framework skill through a structured test-diagnose-fix-verify loop. Run until the skill passes all quality checks.

---

Phase 1: Test Current State

Run skill-test on the target skill.
Record exactly what passed and what failed.
If the skill has a behavioral spec in skill-testing/templates/, run that too.

---

Phase 2: Diagnose

For each failure:
- Missing content? (no pre-conditions, no post-checks, no edge cases) → Missing category
- Shallow content? (< 40 lines per section, lacks detail) → Thin category
- Wrong format? (missing frontmatter, wrong structure) → Format category
- Incorrect logic? (steps don't produce correct results) → Logic category

Rank: which failure is most impactful to fix first?

---

Phase 3: Propose Fix

Present to user: "Skill [name] has [N] issues. Proposed fix: [summary]."
Get approval before modifying.

---

Phase 4: Fix

Apply the fix. Use patch for targeted changes or write_file for major rewrites.
After fixing, re-check: did the fix actually resolve the issue?

---

Phase 5: Retest

Run skill-test again.
If PASS: done. Log the improvement.
If still failing: return to Phase 2. Do not exceed 3 iterations without user review.

---

Phase 6: Log

Write to skill-testing/results/skill-improvement-log.md:
- Skill: [name]
- Issues: [list]
- Changes: [list]
- Result: PASS
- Date: [date]

---

Edge Cases

- Skill is already perfect: "No improvement needed." Done.
- User disagrees with test criteria: Override by user preference. Log: "Deviation from rubric by user choice."
- Fix requires rewriting the entire skill: "This skill needs a full rewrite. That's a larger change than this skill-test-improve loop handles. Consider using design-system instead."

---

Phase 8: Regression Check

After improving the skill:
- Check that no existing section was accidentally removed
- Verify that the skill still produces the same OUTPUT artifacts
- Run a quick mental simulation: "If I follow the improved instructions, do I get the right result?"

---

Phase 9: Documentation

Update skill-testing/catalog.yaml for this skill if applicable:
- has_spec: [true/false]
- last_tested: [date]
- result: [PASS/FAIL]

Keep the catalog up to date so future runs know what's been tested.

---

Edge Cases (continued)

- Skill improvement breaks downstream skills: Unlikely but possible if skills share templates. Check: does this skill reference a shared file that was changed?
- Improvement reduces line count: That's fine if depth is maintained. "Reduced from [N] to [M] lines by removing redundancy."
- User wants to improve all skills at once: "Run this on each skill individually. I can do the next one after this finishes."

Phase 10: Batch Mode

If multiple skills need improvement: run this on each one sequentially.
"Skills [A], [B], [C] all need work. Starting with [A]."

---

Phase 11: Self-Test

After improvement, run skill-test on the improved skill.
If it passes: "Skill [name] now passes all quality checks."
If it doesn't: continue iterating (max 3 iterations per session).

---

Edge Cases

- Skill was already perfect: "No issues found. Skill passes all checks."
- Improvement requires engine-specific knowledge: "This skill depends on [engine] specifics that I can't verify. Mark recommendation as UNVERIFIED."
- User wants to improve skills not in the framework: "This skill-test system is for HMGS framework skills. Custom skills can use the same principles but aren't tracked in the catalog."

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
