name: gate-check
description: Formal phase transition validation. Reads production/stage.txt, runs checkable criteria for the current phase, produces PASS/CONCERNS/FAIL verdict. If PASS, advances stage.txt to next phase. Supports review mode (full/lean/solo) from production/review-mode.txt.
allowed-tools: read_file, write_file, search_files, delegate_task, clarify
model: sonnet
agent: producer

Gate Check — Phase Transition Validation

This skill validates whether the current phase is complete enough to advance to the next one.
Each phase has specific, checkable criteria that must pass before advancing.

Reads production/stage.txt for current phase and production/review-mode.txt for gate intensity.
Output: verdict (PASS / CONCERNS / FAIL) and updated production/stage.txt if advancing.

---

Step 1: Identify Current Phase

Read production/stage.txt.
If the file doesn't exist, ask: "What phase are you in?"
If unknown, run project-stage-detect first.

Read production/review-mode.txt.
If the file doesn't exist, set it to "lean" and note: "Review mode not set — defaulting to 'lean'. Run adopt to configure."

Step 2: Determine Gate Mode

Check review-mode.txt value:
- full: All gates active. Spawn director agents for review. Run all sub-checks.
- lean: Phase-level gates only. Skip director agents. Run primary checks only.
- solo: No gates. Auto-advance with user confirmation. Skip all checks.

If solo: Use clarify "Advance from [current phase] to [next phase]?" If yes, update stage.txt. Done.

Step 3: Run Phase-Specific Gate Checks

3a. Concept → Systems Design
Primary checks (always run):
- [ ] Read: design/gdd/game-concept.md — does it exist with pillars AND anti-pillars?
- [ ] Read: design/gdd/systems-index.md — does it exist with dependency ordering?
- [ ] Read: docs/technical-preferences.md — is engine configured? (not [TO BE CONFIGURED])
- [ ] Read: production/review-mode.txt — is review mode set?

Full mode checks (only if review-mode == full):
- [ ] Delegate to creative-director: "Review the concept doc. Are the pillars specific and differentiated?"
- [ ] Delegate to technical-director: "Is the engine choice appropriate for the concept?"
- [ ] Check: does systems-index.md list at least 3 systems? (Single-system games are rare.)
- [ ] Check: are all systems in the index ordered by dependency? (No circular deps.)

3b. Systems Design → Technical Setup
Primary checks:
- [ ] List GDDs: search_files(pattern='*.md', path='design/gdd/')
- [ ] For each GDD, check: does it have all 8 required sections?
- [ ] Read each GDD status field. Are all MVP GDDs status "Approved"?
- [ ] Search: design/gdd/cross-review-*.md — does cross-GDD review exist?

Full mode checks:
- [ ] Delegate to game-designer: "Review all GDDs for internal consistency and pillar alignment."
- [ ] Check: systems-index.md parenthetical status values? (If found: BLOCKING)
- [ ] Check: do any two GDDs contradict each other? (Rule conflicts, formula range mismatches)

3c. Technical Setup → Pre-Production
Primary checks:
- [ ] Read: docs/architecture/architecture.md — does architecture doc exist?
- [ ] Count: search_files(pattern='adr-*.md', path='docs/architecture/') — at least 3?
- [ ] Read each ADR: is status "Accepted"? (Not "Proposed" or missing)
- [ ] Read: docs/architecture/control-manifest.md — does it exist?
- [ ] Read: design/accessibility-requirements.md — does it exist?

Full mode checks:
- [ ] Delegate to technical-director: "Review ADRs for completeness and dependency ordering."
- [ ] Check: ADR dependency graph has cycles? (If yes: BLOCKING)
- [ ] Check: do ADR engine compatibility fields match technical-preferences.md?

3d. Pre-Production → Production
Primary checks:
- [ ] Count: design/ux/*.md — UX specs exist for key screens?
- [ ] Count: production/epics/**/story-*.md — story files exist for MVP features?
- [ ] Read: production/sprints/sprint-01.md — sprint plan exists?
- [ ] Check: prototypes/vertical-slice/ — vertical slice built and playtested?

Full mode checks:
- [ ] Delegate to producer: "Is the sprint plan achievable? Are there obvious risks?"
- [ ] Check: do stories have acceptance criteria? (At least 1 criterion per story)
- [ ] Check: does sprint duration match team capacity?

3e. Production → Polish
Primary checks:
- [ ] Check: are ALL MVP stories complete? (Count stories with status != Done)
- [ ] Count: production/playtests/report-*.md — at least 3 playtest sessions?
- [ ] Ask user: "Is the core loop validated as fun?"

Full mode checks:
- [ ] Delegate to qa-lead: "Are there any CRITICAL or HIGH bugs open?"
- [ ] Check: is MVP feature set complete? (Cross-reference with systems-index MVP list)

3f. Polish → Release
Primary checks:
- [ ] Count: production/playtests/report-*.md — at least 3?
- [ ] Read: docs/performance/ — performance targets met?
- [ ] Read: design/accessibility-requirements.md — accessibility tier requirements met?

Full mode checks:
- [ ] Delegate to release-manager: "Is the project ready for release? Any blockers?"
- [ ] Check: are there CRITICAL bugs open? (If yes: FAIL)

Step 4: Determine Verdict

Count: PASS / FAIL for each check item.

| Verdict | Criteria | Action |
|---------|----------|--------|
| PASS | All primary checks pass. No FAIL items. | Advance phase. |
| CONCERNS | All primary checks pass. Some full-mode FAIL items. | Advance with notes. Surface concerns. |
| FAIL | One or more primary checks fail. | Do NOT advance. List remediation. |

Step 5: Report

Report format (conversation):

```
## Gate Check: [current phase] → [next phase]

### Mode: [full/lean/solo]

### Results
- [✅/❌] Check 1 — [detail]
- [✅/❌] Check 2 — [detail]

### Verdict: [PASS / CONCERNS / FAIL]

### Next Steps
[If PASS]: Ready to advance to [next phase].
[If CONCERNS]: Advance with these concerns: [list]. Address in next phase.
[If FAIL]: Blocked by: [list]. Fix these before re-running gate-check.
```

Step 6: Advance Phase (if PASS or CONCERNS)

Write the next phase name to production/stage.txt.
If the previous phase was production, write "polish".
If the previous phase was polish, write "release".
Keep the file single-line — just the phase name.

Step 7: Log Session State

Write to production/session-state/active.md:
"Gate check: [current phase] → [next phase] — [verdict]"
