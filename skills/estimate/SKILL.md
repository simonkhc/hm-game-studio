name: estimate
description: Estimate effort for a story or feature. Break into tasks, assign sizes, factor in unknowns.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: producer

Estimate — Effort Sizing

Breaks down a story or feature into implementable tasks and estimates each one.

---

Phase 1: Read Context

Read the story file or GDD being estimated.
Identify: what needs to be built, changed, or configured.

Phase 2: Break Into Tasks

Decompose the work:
- Data/model work (config files, data structures)
- Logic work (functions, algorithms, systems)
- Integration work (connecting to other systems)
- UI work (screens, controls, feedback)
- Test work (writing tests, verifying edge cases)
- Polish work (tuning, feel, juice)

Phase 3: Estimate Each Task

Use t-shirt sizes:
- S: 1-2 hours. Known pattern. Simple implementation.
- M: 3-6 hours. Some unknowns, but approach is clear.
- L: 1-2 days. Significant work or multiple sub-tasks.
- XL: 3-5 days. Complex, multiple systems, high unknowns.

For each task, note:
- Size: S/M/L/XL
- Confidence: HIGH / MEDIUM / LOW
- Unknowns: what could make this bigger

Phase 4: Total

Sum sizes (S=1, M=3, L=5, XL=8).
Present: "Estimated: [N] points / [hours/days]. Confidence: [HIGH/MEDIUM/LOW]."

Phase 5: Confidence Levels
For each task, assign a confidence level:
- HIGH: similar work done before, approach is clear
- MEDIUM: some unknowns, but solvable
- LOW: significant unknowns, research needed

If any task has LOW confidence: "Task [name] has significant unknowns. Consider a timeboxed spike (2-4 hours) before committing to the estimate."

Phase 6: Total and Buffer
Total points: sum of all tasks.
Add 20% buffer for unknowns: adjusted = total * 1.2.
"Raw estimate: [N] points. With 20% buffer: [M] points."

Phase 7: Recommendation
"Estimated effort: [N] points ([range in hours/days]). Confidence: [HIGH/MEDIUM/LOW].
This is [sprint-sizes] worth of work for a [sprint-duration] sprint.
[Suggestion: fits comfortably / may be tight / too large for one sprint]."

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

Phase 11: Integration with Other Skills

This skill pairs well with:
- [Related skill 1]: Run before this to prepare context
- [Related skill 2]: Run after this to validate output
- [Related skill 3]: Run alongside this for parallel work

---

Phase 12: Time Estimates

Typical time to run this skill:
- First time: [N] minutes (learning curve)
- Subsequent runs: [N] minutes (familiar path)
- Full depth: [N] minutes (all phases)

---

Final Verification

- [ ] All required outputs exist
- [ ] No unintended modifications to other files
- [ ] User confirms the result is correct
- [ ] Next action is clear

If any verification fails: re-run the relevant phase. Do not mark as complete until all checks pass.
