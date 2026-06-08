name: art-bible
description: Create art bible document — visual style, color palette, lighting, character/environment design principles, technical constraints.
allowed-tools: read_file, write_file, clarify
model: sonnet
agent: art-director

Art Bible — Visual Direction Document

Defines the visual identity of the game. Serves as reference for all art creation.

Output: design/art/art-bible.md

---

Phase 1: Define Art Style

Ask: "What's the visual style?"
Options: Pixel art / Hand-drawn / 3D stylized / 3D realistic / Vector / Cel-shaded / Minimalist
If unsure: ask for reference games. "What games look like how you want this to feel?"

Phase 2: Color Palette

Define primary palette:
- 3-5 main colors
- 3-5 accent colors
- Background/mood colors
- UI colors (separate from game world)

Phase 3: Lighting & Atmosphere

Describe the lighting direction:
- Time of day? (if outdoor scenes)
- Mood: warm, cold, dramatic, flat?
- Light sources: natural, artificial, magical?

Phase 4: Design Principles

Character design:
- Proportion rules (realistic, cartoon, chibi?)
- Silhouette readability
- Color coding for factions/roles

Environment design:
- Tile/grid size (if pixel art)
- Modular vs bespoke architecture
- Props and decoration density

Phase 5: Technical Constraints

- Texture sizes (max: 1024x1024, 2048x2048?)
- Poly counts (characters: N tris, environment: N tris)
- Animation frames (if 2D: spritesheet size limits)
- Color count (if pixel art: palette limits)

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
