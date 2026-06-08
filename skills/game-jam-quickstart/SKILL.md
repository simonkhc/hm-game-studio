name: game-jam-quickstart
description: Minimal framework setup for game jams. Skip heavy process, keep essential structure. Solo review mode.
allowed-tools: write_file, clarify
model: sonnet
agent: producer

Game Jam Quickstart — Minimal Framework

Sets up the minimum viable project structure for a game jam (48-72 hours).
No GDD reviews, no ADRs, no sprint plans. Just build.

---

Phase 1: Minimal Setup

Write these files:
- production/stage.txt → "concept"
- production/review-mode.txt → "solo" (no gates)
- docs/technical-preferences.md → engine, language, naming

Phase 2: One-Page Concept

Write design/gdd/game-concept.md with just:
- One-sentence elevator pitch
- 3 pillars
- Core loop (30-sec + session)

Phase 3: Minimal Systems

Write design/gdd/systems-index.md with:
- No more than 5 systems
- Label each: MUST HAVE / NICE TO HAVE
- No dependency graph needed

Phase 4: Time Budget

| Day | Focus |
|-----|-------|
| 1 | Core mechanic prototype working |
| 2 | Content + features |
| 3 | Polish + Web build + submit |

Phase 5: Build

Start implementing. Skip reviews, skip tests, skip documentation.
Focus on: functional prototype playable by deadline.

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
