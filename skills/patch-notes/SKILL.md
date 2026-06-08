name: patch-notes
description: Generate player-friendly patch notes from changelog or git history. Group by player-visible categories.
allowed-tools: read_file, terminal, write_file, clarify
model: sonnet
agent: community-manager

Patch Notes — Player-Facing Release Notes

Translates technical changelogs into player-friendly language. Focuses on what players will notice.

Output: production/releases/patch-notes-v[VER].md

---

Phase 1: Get Technical Changes

Read the changelog from production/releases/changelog-v[VER].md.
If it doesn't exist: terminal("git log --oneline --no-decorate [range]")

Phase 2: Translate

Rewrite each technical entry in player-friendly language:
- "Fixed bug where save data could become corrupted on scene transition" → "Fixed a rare crash when moving between areas"
- "Refactored input handling system" → DON'T include (not player-visible)
- "Adjusted difficulty curve for early levels" → "Early levels are now more forgiving"

Rule: if the player won't notice or care, leave it out.

Phase 3: Group

Organize into categories:
- New Features (new functionality)
- Improvements (changes to existing features)
- Bug Fixes (issues resolved)
- Known Issues (what's still being worked on)

Phase 4: Write

Write to production/releases/patch-notes-v[VER].md in player-friendly tone.

Phase 5: Tone Check

Patch notes should sound human, not corporate:
- BAD: "Implemented optimization pass to reduce frame time variance"
- GOOD: "Smoother performance, especially in outdoor areas"

Read through the final draft. Flag any remaining technical jargon.

Phase 6: Post-Checks

- Ask: "Should I save this to production/releases/ or just leave it in the conversation?"
- If saved: file exists at production/releases/patch-notes-v[VER].md

---

Edge Cases
- No changes since last release: "No significant changes in this release. Just bug fixes."
- Breaking changes: Clearly flag: "⚠️ Save files from v1.0 are NOT compatible with v1.1"

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
