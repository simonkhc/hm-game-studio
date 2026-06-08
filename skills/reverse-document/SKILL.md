name: reverse-document
description: Generate design documents from existing code. Read source, extract design intent, write GDD-format document.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: systems-designer

Reverse Document — Code-to-Design Recovery

Generates design documentation from existing implementation. Useful when inheriting code without docs, or when implementation has diverged from design.

Output: design/gdd/[system]-reverse.md

---

Phase 1: Identify System

Ask: "Which system/subsystem to document?"
Or read the specified file path.

Phase 2: Read Source Code

Read all source files for the system.
Extract:
- What the system does (entry points, main functions)
- State it manages (variables, data structures)
- Inputs it accepts (parameters, events, signals)
- Outputs it produces (return values, emitted signals, file writes)
- Config values it reads (file paths, constants)

Phase 3: Extract Design Intent

For each behavior, summarize: "This does X because Y."
If the reason isn't clear from code, flag: "Intent unclear — needs designer review."

Phase 4: Write GDD-Format

Write to design/gdd/[system]-reverse.md using the 8-section format:
1. Overview — what the system actually does
2. Player Fantasy — inferred from implementation
3. Detailed Rules — extracted from code logic
4. Formulas — extracted from calculations
5. Edge Cases — found in code comments or error handling
6. Dependencies — what it actually calls/uses
7. Tuning Knobs — config values it actually reads
8. Acceptance Criteria — testable from observable behavior

Phase 5: Flag Divergence

If an existing GDD exists for this system, compare:
- Where implementation differs from design
- Flag each difference: INTENTIONAL / UNINTENTIONAL / UNKNOWN

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
