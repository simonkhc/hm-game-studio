name: content-audit
description: Verify content completeness against GDDs. Check all required levels, dialogue, items exist. Flag gaps, duplicates, inconsistencies.
allowed-tools: read_file, search_files, write_file, clarify
model: sonnet
agent: game-designer

Content Audit — Completeness Verification

Compares what the GDDs say should exist against what's actually in the project files.

---

Phase 1: Extract Required Content

Read each GDD. Extract the list of content required:
- Levels/scenes (from level design docs)
- Dialogue lines (from narrative docs)
- Items/abilities (from gameplay docs)
- Quests/missions (from progression docs)
- Tutorial steps (from UX docs)

Phase 2: Check What Exists

For each content item from GDDs, check if the corresponding file exists:
- Scenes: search src/ or assets/ for .tscn/.unity/.umap files
- Dialogue: search assets/dialogue/ or equivalent
- Items: search assets/data/ for item configs
- Tutorial: search src/ui/ for tutorial scripts

Phase 3: Report

| Content | GDD says | Project has | Status |
| Level 1 | scene_01.tscn | scene_01.tscn | ✅ |
| Level 2 | scene_02.tscn | missing | ❌ |
| Dialogue A | dialogue_01.json | dialogue_01.json | ✅ |

Total: [N] required, [M] exist, [P] missing

Phase 4: Flag Inconsistencies

For content that exists but differs from GDD:
- Name mismatch: GDD calls it X, file is named Y
- Quantity mismatch: GDD says 10 levels, only 5 exist
- Format mismatch: GDD specifies JSON, file is YAML

Phase 5: Report

Write to docs/content-audit-[date].md.
Flag CRITICAL gaps (missing MVP content) vs MISSING (nice-to-have).

---

Edge Cases
- GDD says content exists but doesn't specify format: Note as untestable.
- File exists but is empty placeholder: Count as missing, not existing."

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
