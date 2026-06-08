name: test-helpers
description: Create test utility functions, mock objects, and fixtures. Identifies repeated test patterns and centralizes them.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: qa-tester

Test Helpers — Utility and Mock Creation

Reduces test duplication by extracting common setup/teardown patterns, mock objects, and assertion helpers.

---

Phase 1: Identify Patterns

Read existing tests in tests/. Look for repeated code:
- Same setup code in multiple test files → extract to helper
- Same mock objects created in multiple places → create central mock factory
- Same assertions used repeatedly → create custom assertion helper

Phase 2: Create Helper File

Write to tests/helpers/test_helpers.gd or equivalent.
Include:
- setup_scene(path): loads a scene for testing
- create_mock_system(name, methods): creates a mock
- assert_approx_equal(a, b, epsilon): floating point comparison
- run_for_frames(count): advances the game loop

Phase 3: Update Existing Tests

Offer to refactor existing tests to use the new helpers.
Ask user before modifying working tests.

Phase 5: Document

Write docstrings for each helper function:
- What it does
- Parameters and types
- Return value
- Example usage

Phase 6: Verify

Use the helpers in one existing test file.
Confirm the test still passes.
Show the user: "Here's how the refactored test looks with the new helper."

---

Edge Cases
- No existing tests: Create helpers as foundation. Note: "No tests to refactor yet, but helpers are ready for when you write tests."
- Engine-specific test framework: Helpers must match testing patterns (GUT for Godot, NUnit for Unity, etc.)"

Phase 6: Practical Application

After performing the core analysis, offer to act on findings:
- "I found [N] issues. Should I fix them now or create stories for them?"
- "Top recommendation: [single most impactful change]."

Phase 7: Documentation Update

If findings affect other documentation:
- "GDD [name] needs updating: [specific change]."
- "ADR [name] is affected by this finding: [impact]."
- "Should I update these now?"

Phase 8: Prevention

To prevent this issue from recurring:
- "Add a check to [relevant skill]: [specific addition]."
- "Update the coding rules: [specific rule]."
- "Add to code review checklist: [specific item]."

---

Quality Checklist

Every skill should meet these standards:
- [ ] Pre-conditions: what must exist before running
- [ ] Clear phases/steps with numbered instructions
- [ ] Specific file paths and tool commands
- [ ] Branching logic: if X, do Y; if error, do Z
- [ ] Edge cases explicitly handled
- [ ] Output artifacts defined with exact paths
- [ ] Post-checks to verify success
- [ ] YAML frontmatter: name, description, allowed-tools, model, agent
- [ ] 100+ lines of substantive content

---

Edge Cases

- User runs this at the wrong phase: "This skill is designed for [phase]. You're in [current phase]. Consider [alternative skill] instead."
- Engine-specific variations: "This skill assumes [engine]. If you're using a different engine, adjust the file paths and commands accordingly."
- User cancels mid-skill: "Partial results are saved. Re-run to continue."

---

Phase 9: Decision Tree

If the user asks "what if I skip this step?":
- "Skipping [step] means [consequence]. Acceptable if [condition]."
- "If you're in solo mode, this step is optional by design."

If the user asks "what tool do I use for this?":
- "Use [hermes_tool] for [purpose]."
- "Example: read_file(path) to read the file, search_files(pattern, path) to find occurrences."

If the user encounters an error:
- Error: [common error message]
- Cause: [what went wrong]
- Fix: [how to resolve]

---

Phase 10: Multi-Project Considerations

If you're running this across multiple game projects:
- Each project has its own hm-game-studio/ reference (same framework, different project)
- Save data lives in each project's production/ directory
- Skills are shared across all projects

---

Verification

After running this skill, confirm:
- [ ] Output file exists at the expected path
- [ ] Content is correct
- [ ] Related files are updated (if applicable)
- [ ] User knows the next step

Not sure? Run the post-checks section again.
