name: architecture-review
description: Validates all ADRs together — topological dependency sort detects cycles, engine compatibility verification against technical-preferences.md, GDD alignment checks, TR-ID registry bootstrap. Returns PASS/CONCERNS/FAIL with specific findings.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: technical-director

Architecture Review — ADR Validation Gateway

Reviews ALL ADRs collectively to ensure they are consistent, complete, and compatible. This is NOT per-ADR review — it finds issues that individual reviews miss: dependency cycles, orphaned ADRs, engine incompatibilities, and missing traceability.

Output: docs/architecture/architecture-review-[date].md + optional TR-ID registry bootstrap

---

Phase 1: Collect ADRs

Search docs/architecture/adr-*.md.
If no ADRs found: "No ADRs to review. Run architecture-decision to create at least 3 ADRs before review."

Read each ADR. For each, extract into a data structure:
- ADR number (from filename: adr-[N]-[slug].md)
- Title (from H1)
- Status (from ## Status field)
- Engine Compatibility (from ## Engine Compatibility field)
- ADR Dependencies (from ## ADR Dependencies field):
  - Depends on: [list of ADR numbers this ADR depends on]
  - Used by: [list of ADR numbers that depend on this ADR]
- GDD Requirements Addressed (from ## GDD Requirements Addressed field)

If Status field is missing: record as "MISSING — BLOCKING"
If Engine Compatibility field is missing: record as "MISSING — HIGH"
If ADR Dependencies field is missing: record as "MISSING — MEDIUM"

---

Phase 2: Dependency Cycle Detection

Build a directed graph from the "Depends on" and "Used by" relationships.
Check for cycles:
- For each ADR, trace its dependency chain
- If ADR-A → ADR-B → ADR-C → ADR-A: CYCLE DETECTED
- A cycle means one ADR's reasoning depends on another that depends back on it — circular logic

If cycles exist:
- List the exact cycle path: "ADR-A → ADR-B → ADR-C → ADR-A"
- Ask: "Which dependency is incorrect?"
- Options: "Fix ADR-A's Depends on" / "Fix ADR-C's Used by" / "I'll investigate"

If no cycles: generate a topological order (dependencies first).
"Valid dependency order: [ADR-1] → [ADR-2] → [ADR-3]..."

---

Phase 3: Status Validation

For each ADR:
| Status found | Action |
|---|---|
| "Accepted" | OK — proceed |
| "Proposed" | "ADR-[N] is still Proposed. Has the decision been made? If yes, update to Accepted." |
| "Superseded" | Check: is there a newer ADR that supersedes it? If not, flag as ORPHANED SUPERSEDED |
| "Deprecated" | OK — no action needed, marked as no longer relevant |
| MISSING | BLOCKING — "ADR-[N] missing Status field. story-readiness will silently pass all ADR checks." |

Count: Accepted / Proposed / Superseded / Deprecated / MISSING

---

Phase 4: Engine Compatibility Check

Read docs/technical-preferences.md for the pinned engine version.
Read each ADR's Engine Compatibility field:
- Value matches pinned engine version → OK
- Value says "N/A" or empty → HIGH risk (post-cutoff API checks blind)
- Value explicitly says "not compatible with [engine]" → BLOCKING
- Field missing entirely → HIGH risk

If the engine version is post-cutoff (newer than LLM training data):
- Check each ADR for APIs that may have changed
- Flag ADRs referencing specific API calls: "ADR-[N] uses [API] — verify this API exists in [engine version]"

---

Phase 5: GDD Alignment

For each ADR, check its "GDD Requirements Addressed" section:
- Do the referenced GDD files exist? (search design/gdd/[slug].md)
- Do the referenced requirements actually appear in those GDDs?
- If ADR addresses a non-existent GDD: flag as ORPHANED ADR
- If ADR addresses a GDD but the requirement doesn't exist in that GDD: flag as MISMATCH

---

Phase 6: Bootstrap TR-ID Registry

Check if docs/architecture/tr-registry.yaml exists.

If it doesn't exist:
- This review can create it
- Collect all TR-referencing patterns from ADRs' GDD Requirements fields
- Create a minimal registry:

```yaml
requirements:
  TR-GEN-001:
    description: "Initial requirement from architecture review"
    source_adr: "ADR-001"
    status: "active"
```

If it exists:
- Read existing TR-IDs
- Check if any ADR references TR-IDs that don't exist in the registry
- Flag orphaned TR-IDs (exist in registry but no ADR references them)

---

Phase 7: Write Review Report

Write to docs/architecture/architecture-review-[date].md:

```
# Architecture Review: [date]

**ADRs reviewed:** [N]
**Status:** PASS / CONCERNS / FAIL

## Dependency Structure
- Cycles: [none / detected and listed]
- Valid topological order: [YES/NO]
- Orphaned ADRs: [none / list]

## Status Summary
- Accepted: [N]
- Proposed: [N]
- Superseded: [N]
- Deprecated: [N]
- Missing Status: [N] ← BLOCKING

## Engine Compatibility
- Pinned engine: [version]
- Compatible ADRs: [N]
- Missing compatibility: [N] ← HIGH
- Incompatible: [N] ← BLOCKING

## GDD Alignment
- Aligned: [N]
- Orphaned: [N]
- Mismatch: [N]

## Verdict
PASS: All checks clear. ADRs are consistent and compatible.
CONCERNS: [specific issues] — address these.
FAIL: [blocking issues] — must fix before proceeding.
```

---

Phase 8: Post-Checks

- Review report written to docs/architecture/
- TR-ID registry exists (or was bootstrapped)
- If BLOCKING issues found: "Cannot pass gate check until these are resolved."
- If PASS: "Architecture is sound. Ready for the next phase."
