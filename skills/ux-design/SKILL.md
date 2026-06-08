name: ux-design
description: Create UX specifications for key screens. Player need, layout zones, states, interaction map, data requirements, accessibility.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: ux-designer

UX Design — Screen Specification

Creates detailed UX specs for game screens — what's on them, how they behave, how they feel.

Output: design/ux/[screen-name].md

---

Phase 1: Identify Screens

Ask: "What screens does the game need? List them."
Typical screens: Main Menu, Settings, Gameplay HUD, Inventory, Dialogue, Pause, Game Over.

For each screen: create a separate spec file.

Phase 2: Per Screen — Player Need

Ask: "What is the player trying to do on this screen?"
Example: "On the gameplay HUD, the player needs to see their health, mana, and active quest at a glance."

Phase 3: Layout Zones

Define screen regions:
- Top bar: [what's here]
- Center: [main content]
- Bottom: [controls/input area]
- Overlay: [popups/modals]

Phase 4: States

For each element, define:
- Default: how it looks when idle
- Hover: how it responds to cursor
- Active: during interaction
- Disabled: when unavailable
- Error: when something goes wrong
- Empty: when no data (e.g., empty inventory)
- Loading: when waiting

Phase 5: Interaction Map

For each interactive element:
- Input: click, tap, hover, keyboard shortcut
- Result: what happens (animation, sound, data change, scene transition)

Phase 6: Accessibility

- Keyboard navigation order? (tab stops)
- Screen reader labels? (aria or equivalent)
- Color-blind safe? (don't rely solely on color for state)
- Font size adjustable?

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
