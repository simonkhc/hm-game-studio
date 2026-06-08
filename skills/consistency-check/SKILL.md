name: consistency-check
description: Cross-referencing check across all project artifacts — GDDs, ADRs, stories, code, configs. Finds naming mismatches, reference errors, contradictions.
allowed-tools: read_file, search_files, write_file, clarify
model: sonnet
agent: technical-director

Consistency Check — Cross-Artifact Validation

Scans all project documentation for contradictions, naming mismatches, and broken references.
Does not modify files — produces a report.

---

Phase 1: Naming Consistency

Extract all system names from design/gdd/systems-index.md.
For each system, check:
- Does design/gdd/[slug].md exist? (GDD file)
- Are there references in code to the same name? Search src/ for the slug.
- Are there story files referencing this system?

Flag: naming mismatches (GDD calls it "PlayerMovement", code calls it "PlayerController")

Phase 2: Reference Integrity

Read each GDD's Dependencies section.
For each dependency listed, check:
- Does the depended-upon GDD exist?
- Does the depended-upon GDD list this system as a dependent?
If not: missing bidirectional dependency reference.

Phase 3: Contradiction Detection

Compare formula parameters across GDDs.
If GDD-A says "max_health = 100" and GDD-B says "max_health = 50": CONTRADICTION
If config file has a different value than GDD spec: OUT_OF_SYNC

Phase 4: Report

Write to docs/consistency-report-[date].md:
- Naming issues: [N]
- Reference gaps: [N]
- Contradictions: [N]
- Verdict: CLEAN / ISSUES_FOUND / CRITICAL

Phase 6: Cross-Reference Integrity

For each file in the project that references another file by name:
- Does the referenced file exist?
- If not: BROKEN REFERENCE
Check: ADR file references, GDD cross-references, story file references, code import paths.

Phase 7: Version Consistency

If the project has version strings in multiple places:
- project.godot (or equivalent) config/version
- README.md version badge
- git tags
- Release checklist version

All should match the current version. Flag any mismatch.

Phase 8: Documentation Freshness

Check doc dates: if a GDD was last updated 6+ months ago but the code has changed recently, the GDD may be stale.
Flag: "GDD [name] last updated [date]. Code in [system] has changed since then. Review for accuracy."

Phase 9: Reporting

Write report with:
- Naming inconsistencies: [N]
- Reference gaps: [N]
- Contradictions: [N] (severity: BLOCKING/HIGH/MEDIUM)
- Version mismatches: [N]
- Stale docs: [N]
- Verdict: CLEAN / ISSUES_FOUND / CRITICAL

---

Phase 12: Quality Gate Integration

If this is part of a release prep:
- "All framework skills should pass skill-test before a framework release."
- "Run: test all skills with category 'gate' and 'utility' first — those are most used."
- "Fix all FAIL before release. NEEDS IMPROVEMENT is acceptable if documented."

---

Phase 13: Self-Referential Check

After improving this skill, run skill-test on itself.
"Skill-improve improves other skills. Does it pass its own quality standards?"
If not: "Meta-issue: skill-improve doesn't meet the standards it enforces for other skills."
Fix skill-improve to meet its own standards, then continue.

---

Edge Cases (continued)

- All skills pass: "Framework quality is good. Run again after adding new skills or making significant changes to existing ones."
- Only one skill fails consistently: "That skill has systemic issues. Consider rewriting rather than patching."
- User wants to automate this: "Create a CI step: weekly, run skill-test on all skills. Report results."

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
