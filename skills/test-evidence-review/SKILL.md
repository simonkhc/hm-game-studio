name: test-evidence-review
description: Review test evidence for completeness. Check coverage meets standards, edge cases tested, no false passes.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: qa-lead

Test Evidence Review — Completeness Check

Reviews existing test evidence against coverage standards. Verifies that what was tested matches what should have been tested.

---

Phase 1: Read GDD Acceptance Criteria

Read the relevant GDD. Extract the Acceptance Criteria section.
List each criterion as a test requirement.

Phase 2: Check Existing Tests

Search tests/ for test files related to this system.
For each test file, extract what behaviors it tests.
Compare against GDD acceptance criteria:
- Criterion covered by test: ✅
- Criterion partially covered: ⚠️ (note: what's missing)
- Criterion not covered: ❌

Phase 3: Quality Check

For each existing test:
- Does it test the intended behavior correctly?
- Does it have false pass risk? (test passes even if code is wrong)
- Does it test edge cases from the GDD?

Phase 4: Report

- Coverage: [N]/[M] criteria covered ([P]%)
- False pass risk: [none / list]
- Missing edge cases: [list]
- Verdict: EVIDENCE SUFFICIENT / NEEDS MORE / FAIL

Phase 5: Report

Write to docs/test-evidence-review-[date].md:
- System reviewed: [name]
- GDD acceptance criteria: [N]
- Tests with coverage: [M]
- Missing coverage: [list]
- Quality concerns: [list]
- Verdict: SUFFICIENT / NEEDS_MORE / FAIL

Phase 6: Offer Action

If FAIL: "Missing coverage on [N] criteria. Should I write the missing tests?"
If SUFFICIENT: "Test evidence is adequate. Ready for release review.""

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
