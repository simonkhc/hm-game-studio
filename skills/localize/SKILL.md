name: localize
description: Prepare game for localization — scan for hardcoded strings, extract to locale files, check text expansion.
allowed-tools: read_file, write_file, search_files, patch, clarify
model: sonnet
agent: localization-lead

Localize — Internationalization Preparation

Makes the game ready for translation by externalizing all user-facing strings.

---

Phase 1: Scan for Hardcoded Strings

Search src/ for string literals that appear to be user-facing:
- UI labels: search for "print(", "label.text = ", "text = "
- Dialogue: search for direct dialogue strings
- Error messages: descriptive text shown to players

For each string found, record:
- File path and line
- The exact string
- Context (is it a button label? error message? tutorial text?)

Phase 2: Extract to Locale File

Create or update assets/locales/zh.json (or the primary language).
Format:
```json
{
  "ui.play_button": "Play",
  "ui.settings_button": "Settings",
  "error.save_failed": "Failed to save game. Please try again."
}
```

Each string gets a key based on context (ui., error., dialogue., tutorial.).

Phase 3: Replace in Code

For each hardcoded string found:
Replace with a localization function call:
- Godot: tr("ui.play_button")
- Unity: LocalizationSettings.StringDatabase.GetLocalizedString("ui.play_button")
- Unreal: NSLOCTEXT("", "ui.play_button", "Play")

Use patch for each replacement. Get approval per file.

Phase 4: Text Expansion Check

Flag: "English strings shorter than 20 characters may expand 30-300% when translated to German/Russian."
Note: ensure UI layouts can accommodate longer text.

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
