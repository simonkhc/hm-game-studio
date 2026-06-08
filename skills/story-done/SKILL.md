name: story-done
description: 8-phase story completion review. Verifies acceptance criteria against GDD, checks for deviations, runs code review, generates completion report with COMPLETE / COMPLETE WITH NOTES / BLOCKED verdict, updates story status, and surfaces the next ready story.
allowed-tools: read_file, write_file, search_files, patch, clarify, delegate_task
model: sonnet
agent: lead-programmer

Story Done — Completion Review

Called when a story is implemented. Runs a structured 8-phase review before marking the story as complete.

The goal: catch issues now, not during integration or playtesting.

---

Phase 1: Read the Story

Read the story file from production/epics/[epic-slug]/story-[name].md.

Extract:
- Story title and epic
- Acceptance criteria list (checkbox items)
- ADR references (ADR-N pattern)
- GDD reference (which GDD this implements)
- Technical notes (file paths, engine notes)
- Dependencies (other stories this depends on)

If the story file doesn't exist: stop. "Story file not found at [path]. Check the path and try again."

Phase 2: Load Context

Read the referenced GDD. Extract:
- The 8 sections (verify the implementation matches the design)
- The Acceptance Criteria section (the story criteria should derive from these)
- The Formulas section (verify calculations match)

Read the referenced ADRs. For each:
- Check that the implementation follows the ADR's decision
- If it doesn't: flag as BLOCKING deviation (unless ADR was superseded)

Read docs/architecture/control-manifest.md.
Extract the Manifest Version stamp.
Check: does the story file reference this version? If the manifest version is newer than the story's version, flag: "MANIFEST STALE — story references v[X], current manifest is v[Y]. Review for compliance."

Phase 3: Verify Acceptance Criteria

For each criterion in the story, classify and verify:

| Type | Method | How |
| AUTO | Run test | Find and run the corresponding test file. terminal("[test-runner] [test-file]") |
| MANUAL | User verification | Ask user: "Does [criterion] work? Can you demonstrate it?" |
| DEFERRED | Note only | "Cannot verify until [dependent system] is built. Deferred."

Record each: PASS / FAIL / NOT TESTED / DEFERRED.

Rules:
- If any AUTO criterion FAILS: BLOCKED. Do not proceed until fixed.
- If any MANUAL criterion fails user verification: BLOCKED or COMPLETE WITH NOTES (user decides).
- If ALL criteria PASS: proceed.

Phase 4: Check GDD/ADR Deviations

Compare the implementation against the GDD and ADRs:

| Finding | Severity | Action |
|---|---|---|
| Implementation matches docs exactly | — | None |
| Deviation with valid technical reason | ADVISORY | Document in story notes. Example: "GDD says 7-day growth cycle. Implementation uses 5 days because player testing showed 7 was too slow." |
| Deviation that needs design approval | BLOCKING | Escalate: "The implementation does X, but the GDD specifies Y. This needs game-designer approval before we accept it." |
| Deviation that changes architecture | BLOCKING | Escalate: "The implementation uses pattern A, but ADR-003 specifies pattern B. This needs lead-programmer review." |

If BLOCKING: stop here. Surface to user. Do not proceed to Phase 5.

Phase 5: Code Review

Run basic code quality checks on the changed files:

1. Architecture clarity: are boundaries and data flow explicit?
   Search the changed files for patterns that cross system boundaries inappropriately
   (e.g., UI code directly modifying game state)

2. Engine idioms: does the code follow engine conventions?
   Check: are Godot signals used instead of direct node references? Are Unity events used?

3. Data-driven design: are tunable values in config files?
   Search the changed files for numeric literals that should be config values.
   Acceptable: 0, 1, 100 (common defaults)
   Flag: any other hardcoded number without explanation.

4. Performance considerations: any obvious issues?
   Check: allocations in update loops, inefficient data structures, repeated file access.

5. Test coverage: are there tests for the new code?
   Search tests/ for test files related to this system.
   If none exist: flag as NOTE (not BLOCKING for individual stories, but track as tech debt).

If review-mode.txt says "full": delegate to lead-programmer for thorough review.
If "lean" or "solo": run the checks yourself.

Phase 6: Generate Completion Report

Compile findings into a verdict:

| Verdict | Meaning |
|---|---|
| COMPLETE | All criteria met. No blocking issues. Code review passed. |
| COMPLETE WITH NOTES | All criteria met. Non-blocking issues documented. User acknowledges. |
| BLOCKED | Blocking issues must be resolved before the story can be accepted. |

Phase 7: Update Story File

Update the story file's Status field:
- COMPLETE → Status: Complete
- COMPLETE WITH NOTES → Status: Complete (add completion_notes section)
- BLOCKED → Status: Blocked (add blocked_reason section)

Add a completion_notes section at the bottom:
```
## Completion Notes
**Date:** [date]
**Reviewer:** HMGS (lead-programmer)

### Deviations
- [None / list with reasoning]

### Tech Debt
- [None / list with file paths and severity]

### Blockers (if BLOCKED)
- [List of blocking issues]
```

Phase 8: Surface Next Story

Read the current sprint plan (production/sprints/sprint-[N].md).
Find the next story with status "Ready" or "In Progress".
Present:
"Story [name] is [verdict]. The next story is [next story name] in [epic]. Ready to start?"

---

Edge Cases

- No tests exist for the system: Flag as tech debt, not a blocker. "No test coverage for this system. Consider adding tests in the next sprint."
- Implementation is perfect but acceptance criteria were wrong: Update the acceptance criteria. Get user approval. Mark as COMPLETE WITH NOTES.
- Story scope crept during implementation: Flag any work done that wasn't in the original story. Don't count it against completion, but suggest creating a follow-up story for the extra work.
- User wants to mark as COMPLETE despite failing criteria: Let them. Set status to "COMPLETE WITH NOTES" and document the gap. It's their project.
