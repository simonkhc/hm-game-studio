name: qa-plan
description: Create a test plan for a feature or release — test areas, test types, acceptance thresholds, schedule.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: qa-lead

QA Plan — Test Strategy Definition

Creates a structured test plan for an upcoming feature or release.
Defines what to test, how, and to what standard.

Output: production/qa-plan-[date].md

---

Phase 1: Read Scope

Read the sprint plan, epic, or stories being tested.
Identify: what features/systems are in scope? What's out of scope?

Phase 2: Define Test Areas

For each system in scope, define:

Unit tests:
- Individual functions and classes
- All formulas from GDD
- All edge cases from GDD
- All acceptance criteria become test cases

Integration tests:
- System-to-system interactions
- Data flow across boundaries
- State transitions

Manual tests:
- UX flow completion
- Visual/audio quality
- Feel and polish assessments

Phase 3: Set Thresholds

What's acceptable?
- Unit tests: 100% pass required
- Integration: 100% pass required for critical paths
- Manual: all blocking issues resolved

Phase 4: Write Plan

Write to production/qa-plan-[date].md with scope, test areas, and schedule.

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
