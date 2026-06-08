name: project-stage-detect
description: Full project audit to determine current phase. Scans for artifacts by phase (concept docs in design/gdd/, ADRs in docs/architecture/, stories in production/epics/, source code in src/, playtest reports in production/playtests/, release checklists). Reports current phase, missing artifacts for current phase, and gaps for next phase.
allowed-tools: read_file, search_files, write_file, clarify
model: sonnet
agent: producer

Project Stage Detect — Phase Determination

Audits the project's artifacts to determine which development phase the project is in.
This skill is READ-ONLY. It does not modify any files.

Output: docs/project-stage-report.md

---

Phase 1: Scan for Artifacts by Phase

1a. Phase 1 (Concept) artifacts:
Check: does design/gdd/game-concept.md exist?
Check: does design/gdd/systems-index.md exist?
Check: does docs/technical-preferences.md exist?
Check: does production/review-mode.txt exist?
Count: source files in src/ (any extension)
→ Phase 1 complete if: concept.md + systems-index.md + technical-preferences exist

1b. Phase 2 (Systems Design) artifacts:
Count: GDD files in design/gdd/*.md (excluding game-concept.md and systems-index.md)
For each GDD: check Status field (Approved? In Review?)
Check: does design/gdd/cross-review-[date].md exist?
→ Phase 2 complete if: all MVP GDDs exist and are Approved, cross-review exists

1c. Phase 3 (Technical Setup) artifacts:
Count: ADR files in docs/architecture/adr-*.md
For each: check Status (Accepted?)
Check: does docs/architecture/architecture.md exist?
Check: does docs/architecture/control-manifest.md exist?
Check: does design/accessibility-requirements.md exist?
→ Phase 3 complete if: 3+ Accepted ADRs, architecture doc, control manifest, accessibility requirements

1d. Phase 4 (Pre-Production) artifacts:
Count: UX specs in design/ux/*.md
Count: epics in production/epics/*/EPIC.md
Count: stories in production/epics/**/story-*.md
Count: sprint plans in production/sprints/sprint-*.md
Check: does prototypes/vertical-slice/ exist?
→ Phase 4 complete if: UX specs, epics, stories, sprint plan, vertical slice exist

1e. Phase 5 (Production) artifacts:
Count: source files in src/ with real content (>10 lines)
Count: completed stories (status == "Complete" or "Done")
Count: sprint retro reports in production/retrospectives/
→ Phase 5 in progress if: source files exist and stories are being completed

1f. Phase 6 (Polish) artifacts:
Count: playtest reports in production/playtests/report-*.md
Check: does docs/performance/ exist with profile reports?
Check: does docs/balance/ exist with review reports?
→ Phase 6 in progress if: 1+ playtests exist

1g. Phase 7 (Release) artifacts:
Count: release checklists in production/releases/release-*-checklist.md
Count: tags from git: terminal("git tag --list 'v*'")
→ Phase 7 in progress if: release checklist exists or git tag exists

---

Phase 2: Determine Current Phase

Use the following logic (first match wins):
- If ANY Phase 7 artifact exists: Phase 7 (Release) — may also be in maintenance
- If 3+ playtest reports exist AND performance reports exist: Phase 6 (Polish)
- If source files exist AND stories are being completed: Phase 5 (Production)
- If stories and sprint plan exist: Phase 4 (Pre-Production) — may also be in Production if code exists
- If ADRs and architecture doc exist: Phase 3 (Technical Setup)
- If GDDs exist: Phase 2 (Systems Design)
- If concept doc exists: Phase 1 (Concept)
- If NOTHING exists: "Fresh project — not started"

If there's ambiguity (e.g., stories AND code both exist): check production/stage.txt for authoritative phase.

---

Phase 3: Identify Gaps

For the determined current phase:
- List which required artifacts for THIS phase are missing
- These are gaps that need to be filled before advancing

For the NEXT phase:
- List which artifacts will be required
- These are preparation items

Example:
Current phase: Phase 2 (Systems Design)
Current gaps: "GDD for [system] is still 'In Review', cross-review not yet run"
Next phase prep: "Will need: 3 ADRs, architecture doc, control manifest, accessibility requirements"

---

Phase 4: Write Report

Write to docs/project-stage-report.md:

```
# Project Stage Report

**Date:** [YYYY-MM-DD]

## Current Phase
[Phase name]

## Evidence

### Phase 1 (Concept)
- game-concept.md: [EXISTS / MISSING]
- systems-index.md: [EXISTS / MISSING]
- technical-preferences.md: [EXISTS / MISSING]
- review-mode.txt: [EXISTS / MISSING]

### Phase 2 (Systems Design)
- GDDs: [N] — [all approved / some in review / some missing]
- Cross-review: [EXISTS / MISSING]

### Phase 3 (Technical Setup)
- ADRs: [N] — [all accepted / some proposed]
- Architecture doc: [EXISTS / MISSING]
- Control manifest: [EXISTS / MISSING]
- Accessibility: [EXISTS / MISSING]

### Phase 4 (Pre-Production)
- UX specs: [N]
- Epics: [N]
- Stories: [N]
- Sprint plan: [EXISTS / MISSING]
- Vertical slice: [EXISTS / MISSING]

### Phase 5 (Production)
- Source files: [N]
- Completed stories: [N]
- Sprints completed: [N]

### Phase 6 (Polish)
- Playtest reports: [N]

### Phase 7 (Release)
- Release checklists: [N]

## Gaps (Current Phase)
- [Gap 1] — needs: [action]
- [Gap 2] — needs: [action]

## Gaps (Next Phase)
- [Gap 1] — prepare: [action]

## Recommended Next Action
[Most impactful single step to advance]
```

---

Phase 5: Post-Checks

- Report written to docs/project-stage-report.md
- If stage.txt disagrees with detected phase: "production/stage.txt says [phase A], but artifacts suggest [phase B]. Update stage.txt?"
- User knows exactly what phase they're in and what to do next.
