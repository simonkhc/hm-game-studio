name: launch-checklist
description: Cross-department launch readiness validation. Engineering, Design, Art, Audio, QA, Narrative, Localization, Accessibility, Store.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: release-manager

Launch Checklist — Go/No-Go Decision

Full cross-department validation before shipping. Each department gets Go or No-Go. All must be Go.

Output: production/releases/launch-v[VER]-readiness.md

---

Phase 1: Department Checks

Engineering: builds stable? crash rate acceptable? load times OK?
Design: features complete? tutorial works? difficulty curve correct?
Art: all assets present? no missing textures? quality bar met?
Audio: all sounds present? mixing levels correct? no popping/crackling?
QA: open bugs by severity. CRITICAL = 0, HIGH = 0, MEDIUM < N, LOW acceptable.
Narrative: all dialogue present? lore consistent? no placeholder text?
Localization: all strings translated? no truncation? text expansion handled?
Accessibility: committed tier requirements met? color-blind modes working?
Store: metadata complete? screenshots ready? trailer done?

Phase 2: Go/No-Go

Each department gets: GO / NO-GO / NOT APPLICABLE
If any are NO-GO: launch blocked. List what must be fixed.

Phase 3: Assemble Report

Collect all department verdicts into one table:
| Department | Verdict | Notes |
| Engineering | GO/NO-GO | 
| Design | GO/NO-GO | 
| Art | GO/NO-GO | 
| Audio | GO/NO-GO | 
| QA | GO/NO-GO | 
| Narrative | GO/NO-GO | 
| Localization | GO/NO-GO | 
| Accessibility | GO/NO-GO | 
| Store | GO/NO-GO | 

If any NO-GO: launch is blocked. List required fixes with owners.
If all GO: proceed to ship.

Write to production/releases/launch-v[VER]-readiness.md.

---

Edge Cases
- No build available: Block launch. "Can't validate without a build."
- Platform certification pending: Flag as NOT APPLICABLE. Note: "Cert must be complete before store submission."
- Single developer: Department checks still apply. Just all assigned to the same person."

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
