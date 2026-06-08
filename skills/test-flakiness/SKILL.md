name: test-flakiness
description: Identify and fix flaky tests — tests that pass inconsistently without code changes. Run each candidate test 3+ times, detect timing-dependent failures, shared state corruption, unseeded randomness, and external dependency issues. Apply targeted fix per root cause. Verify with 5 consecutive passes. Quarantine unfixable flaky tests.
allowed-tools: terminal, read_file, write_file, patch, clarify
model: sonnet
agent: qa-lead

Test Flakiness — Inconsistent Test Resolution

Flaky tests are worse than no tests: they train developers to ignore test failures. This skill systematically identifies, diagnoses, and resolves flaky tests.

---

Phase 1: Identify Candidate Tests

Ask: "Which tests have been unreliable?"
If the user names specific tests: use those.
If unknown: search tests/ for all test files. Run each 3 times.

For each test run: terminal("[test-runner] [test-file]") — collect PASS/FAIL per run.
Results matrix:
| Test | Run 1 | Run 2 | Run 3 | Verdict |
|---|---|---|---|---|
| test_watering | PASS | PASS | PASS | STABLE |
| test_growth | PASS | FAIL | PASS | FLAKY (2/3) |
| test_save | FAIL | FAIL | FAIL | CONSISTENTLY FAILING (not flaky — just broken) |

Categorize: STABLE (3/3), FLAKY (mixed), BROKEN (0/3).
Only FLAKY tests need this skill. BROKEN tests need bug-report.

---

Phase 2: Diagnose Root Cause

For each flaky test, check these causes in order:

2a. Timing dependence
The test assumes something happens within a fixed time window.
Signs: wait(), yield_for(), delay(), setTimeout(), Invoke() in the test code.
Fix: replace real-time waits with deterministic triggers. Use a mock time provider.
If the engine provides a test-specific time API (like GutTest's yield_for with simulation): use that.

2b. Shared global state
The test modifies global state (singletons, autoloads, static variables) and doesn't clean up.
Signs: the test passes when run alone but fails when run with other tests.
Fix: add _before_each() or [SetUp] that resets all globals to a known state.
Specific patterns: DayManager singleton modified and not reset, GameState static variables changed.

2c. Random/unseeded values
The test uses random numbers without a fixed seed.
Signs: randf(), randi(), Random.Range(), FMath::FRand(), random seed not set.
Fix: call seed() or Random.InitState() with a fixed value at the start of each test.
"test_growth depends on random weather. Seeding to 42 makes weather deterministic."

2d. External dependency
The test calls network, file system, or hardware that may be unavailable.
Signs: HTTP requests, file reads, hardware sensor access in test code.
Fix: mock the external dependency. Return a fixed value instead of making the real call.
"If the test reads from user://save.json, mock FileAccess to return a pre-defined save state."

2e. Test order dependency
Test A modifies state that Test B relies on, but only when A runs before B.
Signs: tests pass in a specific order but fail when run randomly or in isolation.
Fix: each test must set up its own state. No test should depend on another test's side effects.

---

Phase 3: Apply Fix

For each root cause, propose the specific fix:
"Test [name] flaky because [root cause]. Fix: [specific change]."
Get approval: "Apply this fix?"

Use patch to make the fix.
If the fix involves adding a mock helper: write the helper to tests/helpers/ first, then update the test.

---

Phase 4: Verify

Run the fixed test 5 consecutive times.
If 5/5 pass: "Test [name] is now stable."
If any failure: "Still flaky after fix. Root cause may be more complex or there may be multiple causes."

For persistent flakiness: quarantine the test.
- Rename: test_flaky_[name] (convention: prefix with "flaky_")
- Document: "[name] quarantined on [date]. Root cause unknown."
- Move to tests/quarantined/ directory if it exists.

---

Phase 5: Prevention

After fixing, note the pattern:
"Flakiness cause: [timing/state/random/external/order].
Prevention: [add a check to code review, add a test helper, update test standards]."

Ask: "Should I add a linter rule or CI check to prevent this class of flakiness?"

---

Edge Cases

- All tests are flaky for the same reason: "Systematic issue, not individual. Check: test runner configuration, shared infrastructure, timing framework."
- Test only fails on CI but always passes locally: "Environment-specific. Check: CI speed differences, headless rendering, missing dependencies on CI machine."
- Flaky test hasn't been identified: "Run the full test suite 3 times in CI. Compare results across runs to identify flaky tests."

---

Phase 6: Flaky Test Register

If more than 2 flaky tests exist, create a flaky test register:
Write to docs/quality/flaky-test-register.md:

```
| Test | Root Cause | Status | Last Flaky | Notes |
|---|---|---|---|---|
| test_growth | Timing (yield_for) | Fixed | 2026-06-01 | Increased timeout |
| test_watering | Shared state | Quarantined | 2026-06-05 | Root cause unknown |
```

Update the register each time this skill runs.

---

Phase 7: CI Alert Integration

If using CI, suggest adding a flaky test detector step:
"Run: each test 3 times, report any test that has mixed results."
"This catches flaky tests early, before they undermine CI credibility."

---

Edge Cases (continued)

- Fix causes other tests to fail: The fix revealed a real dependency issue. Those other tests were also depending on the same flaky behavior. Fix them too.
- Flaky test in third-party library: "Can't fix third-party code. Mock or wrap the library call in your tests."
- Developer insists flaky test is fine: "A flaky test that fails 1/10 times will fail CI once per week on a daily build schedule. That's once a week of 'oh, it's just flaky' before anyone investigates a real failure. Fix it."

---

Phase 8: Team Communication

If this is a team project:
- "Inform the team: flaky test [name] has been [fixed/quarantined]."
- "If fixed: the fix is in [file]. Review recommended before merging."
- "If quarantined: create a story to investigate and fix within 1 sprint."

---

Phase 9: Long-Term Tracking

If the same test keeps becoming flaky after being fixed:
- "Test [name] has been fixed [N] times. Root cause may be deeper than diagnosed."
- Recommendation: rewrite the test entirely rather than patching again.

---

Edge Cases (continued)

- Test framework itself is flaky: "The test runner has inconsistent behavior. Investigate test framework version or configuration before blaming individual tests."
- User wants to delete flaky tests instead of fixing: "Deleting tests reduces coverage. Fixing them maintains coverage. Your call — which do you prefer?"
