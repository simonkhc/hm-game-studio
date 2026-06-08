name: milestone-review
description: Review milestone progress — compare completed vs planned, assess blockers, determine go/no-go.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: producer

Milestone Review — Progress Assessment

Evaluates milestone status and determines whether to proceed, adjust, or pause.

---

Phase 1: Read Milestone

Read the milestone definition from production/milestones/ or sprint plan.
Extract: scope, deliverables, exit criteria.

Phase 2: Check Progress

For each deliverable:
- Complete? Check if story status is Done/Complete
- In progress? Check if actively being worked
- Blocked? Check if waiting on something
- Not started? Note as at-risk.

Phase 3: Assess

If >80% complete and no critical issues → PROCEED
If 50-80% complete or non-critical issues → AT RISK
If <50% or critical blockers → BLOCKED

Phase 4: Report
- Milestone: [name]
- Progress: [N]/[M] deliverables
- Blockers: [list]
- Verdict: PROCEED / AT RISK / BLOCKED

Phase 5: Recommend

Based on verdict:
- PROCEED: "Milestone [name] is on track. Continue as planned."
- AT RISK: "Milestone [name] needs attention. Recommend: [action]"
- BLOCKED: "Milestone [name] cannot complete without resolving [blocker]."

Ask: "What would you like to do?"
Options: Continue / Pivot / Pause / Cancel milestone

---

Edge Cases
- Milestone definition doesn't exist: Ask user to define it first. "I can't review without knowing what success looks like."
- All deliverables complete but quality is low: Flag as CONCERNS. "Complete but needs polish before next phase."

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
