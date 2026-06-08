name: asset-spec
description: Catalog all assets needed for the game — entities, screens, UI, environment, VFX, audio. From GDDs and UX specs.
allowed-tools: read_file, search_files, write_file, clarify
model: sonnet
agent: technical-artist

Asset Spec — Asset Requirements Catalog

Creates a comprehensive list of every asset the game needs. Grouped by category with size/format specs.

Output: docs/asset-spec-[date].md

---

Phase 1: Read Design Context

Read all GDDs and UX specs. Extract every visual and audio element described:
- Characters, enemies, NPCs
- Environment tiles, props, backgrounds
- UI elements (buttons, panels, icons, fonts)
- VFX (particles, shaders, lighting)
- Audio (music tracks, SFX, ambient, VO)

Phase 2: Categorize

For each asset, record:
- Category: environment / character / ui / vfx / audio
- Type: sprite / model / texture / shader / sound / music
- Quantity: how many variations
- Resolution/size: texture size, poly count, sample rate
- Format: png / glb / wav / ogg
- Priority: MVP / Alpha / Full

Phase 3: Write Spec

Write to docs/asset-spec-[date].md as a table:
| ID | Category | Name | Type | Size/Format | Qty | Priority |

Phase 4: Flag Gaps

Cross-reference: for every system in systems-index.md, does it have corresponding assets?
Any system with no assets flagged: SYSTEM [name] — NO ASSETS SPECIFIED.

Phase 5: Write

Get approval before writing.
Write to docs/asset-spec-[date].md.

---

Edge Cases
- No UX specs exist: Spec from GDDs only. Note: "UX-driven assets may be missing — update after UX specs are written."
- Placeholder vs final assets: Flag as "Placeholder OK" or "Final required" per item."

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
