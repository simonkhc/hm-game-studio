name: adopt
description: Brownfield onboarding — audits existing project artifacts for HMGS format compliance (not just existence), classifies gaps by impact (BLOCKING/HIGH/MEDIUM/LOW), and produces a numbered migration plan. Run this when adopting HMGS on an existing project or upgrading from a previous version. Distinct from project-stage-detect (which checks what exists) — this checks whether what exists will actually work with the framework's skills.
allowed-tools: read_file, write_file, search_files, patch, clarify
model: sonnet
agent: technical-director

Adopt — Brownfield Template Adoption

This skill audits an existing project's artifacts for format compliance with HMGS's skill pipeline, then produces a prioritised migration plan.

This is NOT project-stage-detect. project-stage-detect answers: what exists? adopt answers: will what exists actually work with the framework's skills?

A project can have GDDs, ADRs, and stories — and every format-sensitive skill will still fail silently or produce wrong results if those artifacts are in the wrong internal format.

Output: docs/adoption-plan-[date].md — a persistent, checkable migration plan.

---

Phase 1: Detect Project State

Emit one line before reading: "Scanning project artifacts..." — this confirms the skill is running during the silent read phase.

Then read silently before presenting anything else.

1a. Existence check
---
Read: production/stage.txt — if present, read it (authoritative phase)
Check: design/gdd/game-concept.md — concept exists?
Check: design/gdd/systems-index.md — systems index exists?
Count GDD files: search_files(pattern='*.md', path='design/gdd/') — exclude game-concept.md and systems-index.md
Count ADR files: search_files(pattern='adr-*.md', path='docs/architecture/')
Count story files: search_files(pattern='*.md', path='production/epics/') — exclude EPIC.md
Check: docs/technical-preferences.md — engine configured?
Check: docs/engine-reference/ — engine reference docs present?
Search: docs/adoption-plan-*.md — note the filename of the most recent prior plan if any exist

1b. Infer phase (if no stage.txt)

Use this heuristic:
- 10+ source files in src/ → Production
- Stories in production/epics/ → Pre-Production
- ADRs exist → Technical Setup
- systems-index.md exists → Systems Design
- game-concept.md exists → Concept
- Nothing → Fresh (not a brownfield project — suggest start skill)

1c. Fresh project handling

If the project appears fresh (no artifacts at all), use clarify:
"This looks like a fresh project — no existing artifacts found. /adopt is for projects with work to migrate. What would you like to do?"
Options:
1. "Run start — begin guided first-time onboarding"
2. "My artifacts are in a non-standard location — help me find them"
3. "Cancel"

Then stop — do not proceed with the audit regardless of which option the user picks.

1d. Initial report

Emit: "Detected phase: [phase]. Found: [N] GDDs, [M] ADRs, [P] stories."

---

Phase 2: Format Audit

For each artifact type in scope, check not just that the file exists but that it contains the internal structure the framework requires.

2a. GDD Format Audit

For each GDD file found, check for the 8 required sections by scanning headings:

| Required Section | Heading pattern to look for |
|---|---|
| Overview | ## Overview or ## 1. Overview |
| Player Fantasy | ## Player Fantasy or ## 2. Player Fantasy |
| Detailed Rules | ## Detailed Rules or ## Detailed Design or ## 3. |
| Formulas | ## Formulas or ## Formula or ## 4. |
| Edge Cases | ## Edge Cases or ## 5. |
| Dependencies | ## Dependencies or ## Depends or ## 6. |
| Tuning Knobs | ## Tuning Knobs or ## Tuning or ## 7. |
| Acceptance Criteria | ## Acceptance Criteria or ## Acceptance or ## 8. |

For each GDD, record:
- Which sections are present
- Which sections are missing
- Whether it has any content in present sections or just placeholder text ("[To be designed]" or equivalent)

Also check: does each GDD have a **Status**: field in its header block?
Valid values: In Design, Designed, In Review, Approved, Needs Revision.

2b. ADR Format Audit

For each ADR file found, check for these critical sections:

| Section | Impact if missing |
|---|---|
| ## Status | BLOCKING — story-readiness ADR status check silently passes everything |
| ## ADR Dependencies | HIGH — dependency ordering in architecture-review breaks |
| ## Engine Compatibility | HIGH — post-cutoff API risk is unknown |
| ## GDD Requirements Addressed | MEDIUM — traceability matrix loses coverage |
| ## Performance Implications | LOW — not pipeline-critical |

For each ADR, record: which sections present, which missing, current Status value if the Status section exists.

2c. systems-index.md Format Audit

If design/gdd/systems-index.md exists:

Parenthetical status values — search for any Status cell containing parentheses: "Needs Revision (", "In Progress (", etc. These break exact-string matching in gate-check, create-stories, and architecture-review. BLOCKING.

Valid status values — check that Status column values are only from: Not Started, In Progress, In Review, Designed, Approved, Needs Revision. Flag any unrecognised values.

Column structure — check that the table has at minimum: System name, Layer, Priority, Status columns. Missing columns degrade skill functionality.

2d. Story Format Audit

For each story file found:
- Manifest Version: field — present in story header? (LOW — auto-passes if absent)
- TR-ID reference — does story contain TR-[a-z]+-[0-9]+ pattern? (MEDIUM — no staleness tracking)
- ADR reference — does story reference at least one ADR? (check for ADR- pattern)
- Status field — present and readable?
- Acceptance criteria — does the story have a checkbox list (- [ ])?

2e. Infrastructure Audit

| Artifact | Path | Impact if missing |
|---|---|---|
| TR registry | docs/architecture/tr-registry.yaml | HIGH — no stable requirement IDs |
| Control manifest | docs/architecture/control-manifest.md | HIGH — no layer rules for stories |
| Manifest version stamp | In manifest header: Manifest Version: | MEDIUM — staleness checks blind |
| Sprint status | production/sprint-status.yaml | MEDIUM — falls back to manual check |
| Stage file | production/stage.txt | MEDIUM — phase auto-detect unreliable |
| Engine reference | docs/engine-reference/[engine]/VERSION.md | HIGH — ADR engine checks blind |
| Architecture traceability | docs/architecture/architecture-traceability.md | MEDIUM — no persistent matrix |

2f. Technical Preferences Audit

Read docs/technical-preferences.md. Check each field for [TO BE CONFIGURED]:
- Engine, Language, Rendering, Physics → HIGH if unconfigured (ADR skills fail)
- Naming conventions → MEDIUM
- Performance budgets → MEDIUM
- Forbidden Patterns, Allowed Libraries → LOW (starts empty by design)

---

Phase 3: Classify and Prioritise Gaps

Organise every gap found across all audits into four severity tiers:

BLOCKING — Will cause framework skills to silently produce wrong results right now.
Examples: ADR missing Status field, systems-index parenthetical status values, engine not configured when ADRs exist.

HIGH — Will cause stories to be generated with missing safety checks, or infrastructure bootstrapping will fail.
Examples: ADRs missing Engine Compatibility, GDDs missing Acceptance Criteria (stories can't be generated from them), tr-registry.yaml missing.

MEDIUM — Degrades quality and pipeline tracking but does not break functionality.
Examples: GDDs missing Tuning Knobs or Formulas sections, stories missing TR-IDs, sprint-status.yaml missing.

LOW — Retroactive improvements that are nice-to-have but not urgent.
Examples: Stories missing Manifest Version stamps, GDDs missing Open Questions section.

Count totals per tier. If zero BLOCKING and zero HIGH gaps: report that the project is template-compatible and only advisory improvements remain.

---

Phase 4: Build the Migration Plan

Compose a numbered, ordered action plan. Ordering rules:
1. BLOCKING gaps first (must fix before any pipeline skill runs reliably)
2. HIGH gaps next, infrastructure before GDD/ADR content
3. MEDIUM gaps ordered: GDD gaps before ADR gaps before story gaps
4. LOW gaps last

For each gap, produce a plan entry with:
- A clear problem statement (one sentence, no jargon)
- The exact fix command or manual steps
- A time estimate (rough: 5 min / 30 min / 1 session)
- A checkbox - [ ] for tracking

Special case — systems-index parenthetical status values:
This is always the first item if present. Show the exact values that need changing and the exact replacement text. Offer to fix this immediately before writing the plan.

Special case — ADRs missing Status field:
For each affected ADR, the fix is: /architecture-decision retrofit docs/architecture/adr-[NNNN]-[slug].md
List each ADR as a separate checkable item.

Special case — GDDs missing sections:
For each affected GDD, list which sections are missing and reference the design-system skill.

Infrastructure bootstrap ordering — always present in this sequence:
1. Fix ADR formats first (registry depends on reading ADR Status fields)
2. Run architecture-review → bootstraps tr-registry.yaml
3. Run create-control-manifest → creates manifest with version stamp
4. Run sprint-plan update → creates sprint-status.yaml
5. Run gate-check [phase] → writes stage.txt authoritatively

Existing stories note:
"Existing stories continue to work with all framework skills — all new format checks auto-pass when the fields are absent. They won't benefit from TR-ID staleness tracking or manifest version checks until they're regenerated. This is intentional: do not regenerate stories that are already in progress."

---

Phase 5: Present Summary and Ask to Write

Present a compact summary before writing:

```
## Adoption Audit Summary
Phase detected: [phase]
Engine: [configured / NOT CONFIGURED]
GDDs audited: [N] ([X] fully compliant, [Y] with gaps)
ADRs audited: [N] ([X] fully compliant, [Y] with gaps)
Stories audited: [N]

Gap counts:
  BLOCKING: [N] — framework skills will malfunction without these fixes
  HIGH:     [N] — unsafe to run create-stories or story-readiness
  MEDIUM:   [N] — quality degradation
  LOW:      [N] — optional improvements

Estimated remediation: [X items × ~Y min each = roughly Z hours]
```

Before asking to write, show a Gap Preview:
- List every BLOCKING gap as a one-line bullet describing the actual problem
  (e.g. "systems-index.md: 3 rows have parenthetical status values, adr-0002.md: missing ## Status section")
- Show HIGH / MEDIUM / LOW as counts only

If a prior adoption plan was detected in Phase 1, add a note:
"A previous plan exists at docs/adoption-plan-[prior-date].md. The new plan will reflect current project state — it does not diff against the prior run."

Use clarify:
"Ready to write the migration plan?"
Options:
1. "Yes — write docs/adoption-plan-[date].md"
2. "Show me the full plan preview first (don't write yet)"
3. "Cancel — I'll handle migration manually"

If user picks option 2, output the complete plan as a fenced markdown block. Then ask again.

---

Phase 6: Write the Adoption Plan

If approved, write docs/adoption-plan-[date].md with this structure:

```
# Adoption Plan

> **Generated**: [date]
> **Project phase**: [phase]
> **Engine**: [name + version, or "Not configured"]

Work through these steps in order. Check off each item as you complete it.

---

## Step 1: Fix Blocking Gaps
[One sub-section per blocking gap with problem, fix, time estimate, checkbox]

---

## Step 2: Fix High-Priority Gaps
[One sub-section per high gap]

---

## Step 3: Bootstrap Infrastructure
### 3a. Register existing requirements
Run architecture-review — even if ADRs already exist, this run bootstraps the TR registry.
**Time**: 1 session
- [ ] tr-registry.yaml created

### 3b. Create control manifest
Run create-control-manifest
**Time**: 30 min
- [ ] docs/architecture/control-manifest.md created

### 3c. Set authoritative project stage
Run gate-check [current-phase]
**Time**: 5 min
- [ ] production/stage.txt written

---

## Step 4: Medium-Priority Gaps
[One sub-section per medium gap]

---

## Step 5: Optional Improvements
[One sub-section per low gap]
```

---

Phase 6b: Set Review Mode

After writing (or if user cancels), check production/review-mode.txt.

If it exists: Read it and note the current mode — skip the prompt.
If it does not exist: Use clarify:
"One more setup step: how much design review would you like?"
Options:
1. "Full — Director reviews at each key step. Best for teams."
2. "Lean (recommended) — Directors only at phase gate transitions."
3. "Solo — No director reviews. Game jams, prototypes."

Write the choice to production/review-mode.txt immediately — no separate "May I write?" needed.

---

Phase 7: Offer First Action

After writing the plan, pick the single highest-priority gap and offer to handle it immediately:

If there are parenthetical status values in systems-index.md:
Use clarify:
"The most urgent fix is systems-index.md — [N] rows have parenthetical status values that break gate-check, create-stories, and architecture-review right now."
Options:
1. "Fix it now — edit systems-index.md"
2. "I'll fix it myself"
3. "Done — leave me with the plan"

If ADRs are missing ## Status:
Use clarify:
"The most urgent fix is adding ## Status to [N] ADR(s): [list filenames]. Without it, story-readiness silently passes all ADR checks."
Options:
1. "Yes — retrofit [first affected filename] now"
2. "Retrofit all [N] ADRs one by one"
3. "I'll handle ADRs myself"

If GDDs are missing Acceptance Criteria:
Use clarify:
"The most urgent gap is missing Acceptance Criteria in [N] GDD(s): [list filenames]. Without them, create-stories can't generate stories."
Options:
1. "Yes — add Acceptance Criteria to [GDD filename] now"
2. "Do all [N] GDDs one by one"
3. "I'll handle GDDs myself"

If no BLOCKING or HIGH gaps exist:
"The project is template-compatible. What next?"
Options:
1. "Walk me through the medium-priority improvements"
2. "Run project-stage-detect for a broader health check"
3. "Done — I'll work through the plan at my own pace"

---

Collaborative Protocol

- Read silently — complete the full audit before presenting anything
- Show the summary first — let the user see scope before asking to write
- Ask before writing — always confirm before creating the adoption plan file
- Offer, don't force — the plan is advisory; the user decides what to fix and when
- One action at a time — after handing off the plan, offer one specific next step
- Never regenerate existing artifacts — only fill gaps in what exists; do not rewrite GDDs, ADRs, or stories that already have content
