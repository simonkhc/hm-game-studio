name: day-one-patch
description: Prepare post-launch update with known issues that didn't block launch. Prioritize by player impact.
allowed-tools: read_file, search_files, write_file, clarify
model: sonnet
agent: release-manager

Day One Patch — Post-Launch Update Plan

Collects known issues that were deferred from launch and plans a structured post-launch patch.

---

Phase 1: Collect Deferred Issues

Read all open bugs in production/bugs/ with severity LOW or MEDIUM.
Read any deferred tech debt from docs/tech-debt-register.md.
Ask user: "Any other known issues to include?"

Phase 2: Prioritize by Player Impact

For each issue:
- HIGH: player will notice within first hour → fix in day-one patch
- MEDIUM: player will notice eventually → fix in first content update
- LOW: only affects edge cases → fix when convenient

Phase 3: Write Patch Plan

Write to production/releases/day-one-patch-plan.md:
- Issues to fix: list with priorities
- Estimated effort: per issue
- Suggested patch version: 1.0.1
- Timeline: within 1-2 weeks of launch

Phase 4: Coordinate with Team

If multiple issues identified:
- Use delegate_task(tasks=[...]) to assign fixes to appropriate specialists
- Each gets: issue description, file paths, estimated effort

Phase 5: Post-Checks

- Plan written to production/releases/
- Each issue has an owner or is marked UNASSIGNED
- Timeline is realistic (no 'fix everything in 24 hours')

---

Edge Cases
- No issues collected: "No known issues. Day-one patch not needed."
- Critical issue found post-launch: Escalate to hotfix workflow instead.
- User wants to add features as day-one patch: Strongly discourage. "Day-one patches fix bugs. Features go in the first content update."

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
