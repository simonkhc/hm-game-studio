name: scope-check
description: Verify story/feature scope against project capacity and phase. Flags out-of-scope items before they cause schedule slips.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: producer

Scope Check — Feasibility Validation

Checks whether a proposed feature or story is within the project's current scope and capacity.

---

Phase 1: Read Scope

Read production/stage.txt for current phase.
Read the systems-index.md for priority tiers (MVP / Alpha / Full).

Phase 2: Check Feature

For the proposed feature:
- Is it listed in systems-index.md? If not: OUT OF SCOPE (new system)
- What priority? MVP / Alpha / Full?
- If MVP: IS it actually MVP? Or could it be deferred?
- If Alpha/Full: IN SCOPE but deferred. Don't build now.

Phase 3: Check Dependencies

Does this feature depend on systems that aren't built yet?
List dependency chain. If any dependency isn't MVP, the feature can't be built now.

Phase 4: Verdict

IN SCOPE: Within current phase. Build it.
AT RISK: In scope but complex or has unresolved dependencies.
OUT OF SCOPE: Not in current scope. Defer or create new epic.

Phase 5: Present

Present the verdict with reasoning:
- Feature: [name]
- In scope for [phase]? YES/NO
- Priority: [MVP/Alpha/Full]
- Dependencies: [list]
- Dependencies built? YES/NO (if NO: list what's missing)
- Risk: [LOW/MEDIUM/HIGH]
- Verdict: IN SCOPE / AT RISK / OUT OF SCOPE / DEFERRED

Ask user to confirm or discuss.

---

Edge Cases
- Feature sounds small but touches many systems: Flag as HIGH risk despite apparent simplicity.
- User insists on out-of-scope feature: Don't refuse. Flag: "This will delay the current milestone by [estimate]. Accept the risk?"

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
