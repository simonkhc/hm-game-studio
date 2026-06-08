name: regression-suite
description: Run regression tests after changes. Identify affected systems, run relevant tests, report results.
allowed-tools: terminal, read_file, search_files, clarify
model: sonnet
agent: qa-tester

Regression Suite — Post-Change Validation

After code changes, run tests for affected systems and verify nothing broke.

---

Phase 1: Identify Change Scope

Ask: "What changed?" (files modified, systems touched)
If git is available: terminal("git diff --name-only HEAD~1") to see changed files.

Map each changed file to a system (using src/ directory structure):
- src/gameplay/ → gameplay systems
- src/core/ → engine/core systems
- src/ui/ → UI systems

Phase 2: Select Tests

For each affected system:
- Search tests/ for related test files (test_[system]_*.gd or *.cs)
- If multiple test files exist, select those most relevant to the change

Phase 3: Run Tests

For each selected test file: terminal("[test-runner-command] [test-file]")
Collect results: PASS / FAIL / ERROR

If no test runner is configured: run smoke-check instead.
Note: "No test framework detected. Run test-setup to configure one."

Phase 4: Report

Present:
- Tests run: [N]
- Passed: [M]
- Failed: [P]
- New failures: [list] (failures that passed before this change)

Phase 5: Results Summary
- Tests run: [N]
- Passed: [N]
- Failed: [N]
- New failures (previously passing): [list]
- Regressions detected: [list]

Phase 6: Blame Assignment
For new failures:
- "Test [name] used to pass but now fails. This is a regression."
- Use git to find what changed: terminal("git log --oneline -- [test-file]")
- Show the offending commit
- Suggest: "Consider reverting [commit] or fixing [file]."

Edge Cases
- No test framework configured: "Skipping regression tests. Run test-setup first."
- All tests pass: "Full regression pass. No regressions detected."
- Same tests always fail: "These tests were already failing before this change. They're not regressions — they're pre-existing failures."

Phase 7: Automated Regression

If a CI pipeline is configured:
- "Add this regression suite to CI: run before every merge."
- "Block merges if regression tests fail."
- "Tag: [N] regression tests, runtime: [N]s."

Phase 8: Historical Comparison

If previous regression results exist:
- Compare: "Last run: [N] passed, [M] failed. This run: [N] passed, [M] failed."
- "New regressions: [list]. Same failures: [list]."

Phase 9: Severity Classification

For regression failures, classify:
- CRITICAL: Core gameplay loop broken. Block release.
- HIGH: Major feature broken. Fix this sprint.
- MEDIUM: Minor feature broken. Fix next sprint.
- LOW: Cosmetic issue. Fix when convenient.

Phase 10: Reporting

Write to docs/testing/regression-[date].md if any regressions found:
- Tests run, passed, failed
- New regressions with severity
- Previously failing tests still failing
- Recommendations

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
