name: asset-audit
description: Verify asset quality and organization. Naming conventions, format compliance, size budgets, missing files.
allowed-tools: search_files, read_file, write_file, clarify
model: sonnet
agent: technical-artist

Asset Audit — Quality and Organization Check

Reviews all game assets for quality standards compliance.

---

Phase 1: Scan Assets

Search assets/ for all files.
Group by: art/, audio/, vfx/, shaders/, data/, locales/

Phase 2: Check Naming

Each file name should follow conventions from technical-preferences.md.
If no convention specified: snake_case or kebab-case is standard.
Flag: mixed naming styles, spaces in filenames, inconsistent casing.

Phase 3: Check Format

Expected formats:
- Images: .png (UI/sprites), .jpg (backgrounds with no transparency)
- 3D models: .glb/.gltf
- Audio: .wav (SFX), .ogg (music)
- Data: .json
- Shaders: .gdshader / .shader / .hlsl

Flag: wrong formats, uncompressed files that should be compressed.

Phase 4: Check Budgets

Texture sizes: flag anything > 2048x2048 (unless explicitly required)
Audio: flag uncompressed .wav for music (should be .ogg)
File count: flag directories with > 100 files (consider atlas/spritesheet).

Phase 5: Report
- Total assets: [N]
- Naming issues: [list]
- Format issues: [list]  
- Budget issues: [list]
- Verdict: PASS / WARNINGS / FAIL

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
