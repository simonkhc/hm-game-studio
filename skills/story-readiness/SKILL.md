name: story-readiness
description: Validate a story is ready for implementation. Check design complete, ADR coverage, testable criteria, dependencies resolved.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: qa-lead

Story Readiness — Pre-Implementation Validation

Before work begins on a story, verify it has everything needed for successful implementation.

---

Phase 1: Read Story

Read the story file from production/epics/[slug]/story-[name].md.
Extract: description, acceptance criteria, ADR references, dependencies.

Phase 2: Check Design

For each GDD the story references:
- Does the GDD exist? (search design/gdd/)
- Is the GDD status "Approved"? If "Draft" or "Needs Revision": NOT READY

Phase 3: Check Architecture Coverage

For each ADR the story references:
- Does the ADR exist? (search docs/architecture/)
- Is the ADR status "Accepted"? If "Proposed": NOT READY
- If no ADRs referenced but the story touches architecture: NEEDS ADR

Phase 4: Check Acceptance Criteria

Each criterion must be:
- Specific: "Player can water the plant" ✓ vs "Game feels good" ✗
- Testable: can you verify PASS/FAIL after implementation?
- Independent: not dependent on other unimplemented stories

Phase 5: Check Dependencies

For each story dependency referenced:
- Does the dependent story exist? (search production/epics/)
- Is its status "Done" or "Complete"?
- If blocking story not done: BLOCKED

Phase 6: Verdict

READY: All checks pass. Implementation can begin.
NEEDS WORK: Specific gaps listed. Fix before implementing.
BLOCKED: Story depends on incomplete work. Resolve dependencies first.

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
