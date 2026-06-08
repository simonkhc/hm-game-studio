name: sprint-status
description: Quick snapshot of sprint progress — stories by status (Done/In Progress/Blocked/Ready), velocity trend, blockers surfaced. Reads sprint plan and story files. Does NOT modify any files. Reports in conversation.
allowed-tools: read_file, search_files, clarify
model: sonnet
agent: producer

Sprint Status — Progress Dashboard

Provides a real-time snapshot of sprint progress without modifying any files.
Use at standups, before milestone reviews, or when someone asks "how's the sprint going?"

This skill is READ-ONLY.

---

Phase 1: Find Active Sprint

Search production/sprints/sprint-*.md.
If multiple exist, identify the most recent sprint (highest number).
If only one, that's the active sprint.

If no sprint files found:
- "No sprint plans found. Run sprint-plan first."
- Stop.

Read the sprint plan file. Extract:
- Sprint number and goal
- Sprint duration (start → end)
- Story list with priority categories (Must Have / Should Have / Nice to Have)
- Total points (if estimated)

Calculate days remaining: (sprint_end - today) in days.
If sprint is past its end date, flag: "⚠️ Sprint [N] ended [X] days ago. Time for a retrospective."

Phase 2: Check Each Story's Status

For every story listed in the sprint plan:

2a. Read the story file
Path: production/epics/[epic-name]/story-[story-name].md
If file doesn't exist: mark as "UNKNOWN — story file missing"
If file exists: extract Status field

2b. Categorize

Status in file → Display category:
- "Complete" or "Done" → DONE
- "In Progress" → IN PROGRESS
- "Ready" or "Draft" → NOT STARTED
- "Blocked" → BLOCKED
- Missing Status field → UNKNOWN (flag for user)

2c. Check for orphan work
Search for git changes related to the epic but not linked to any story:
terminal("git log --oneline --since=[sprint_start] -- [epic-path]" — if git is available)
If there are commits that don't match any story title: "⚠️ Unlinked work detected: [commit messages]"

Phase 3: Calculate Velocity

If stories have point estimates:
- Total points planned: sum of all Must Have + Should Have
- Points completed: sum of DONE stories' points
- Points in progress: sum of IN PROGRESS stories' points
- Completion rate: (completed / total) * 100

If stories don't have points:
- Count: DONE stories / total stories
- Rough completion: (done / total) * 100

Velocity check:
| Completion | Days elapsed | Verdict |
|---|---|---|
| > 60% | < 50% of sprint elapsed | ON TRACK — ahead of schedule |
| 40-60% | ~50% of sprint elapsed | ON TRACK |
| < 30% | > 50% of sprint elapsed | AT RISK — behind schedule |
| < 20% | > 70% of sprint elapsed | CRITICAL — unlikely to finish |

Phase 4: Identify Blockers

For each BLOCKED story:
- Read the story file for blocked_reason or notes
- Summarize: what's blocking it and why
- Check if the blocker is still valid (ask user if uncertain)

Categorize blockers:
| Type | Meaning | Resolution |
|---|---|---|
| Technical | Implementation blocked by technical issue | Needs investigation or spike |
| Dependency | Waiting on another story | Check dependency story status |
| Design | Design decision not made | Escalate to game-designer |
| External | Waiting on third party (assets, tools) | Escalate to producer |
| Unknown | No reason recorded | Ask user to investigate |

Phase 5: Report

Present the status dashboard:

```
## Sprint [N] Status: [Goal]

**Duration:** [start] → [end] ([X days remaining])

### Progress
[✅/🔴] Done: [N]/[M] stories ([P]%) — [N] points completed
Velocity: [ON TRACK / AT RISK / CRITICAL]

### Stories by Status

**Done ([N])**
- [Story A] — [points] — [epic]
- [Story B] — [points] — [epic]

**In Progress ([N])**
- [Story C] — [points] — [epic]

**Blocked ([N])**
- [Story D] — blocked by: [reason]
- [Story E] — blocked by: [reason]

**Not Started ([N])**
- [Story F] — [points] — [epic]
- [Story G] — [points] — [epic]

### Blockers Summary
| Story | Type | Blocker | Status |
|---|---|---|---|
| D | Technical | [blah] | Unresolved |

### Recommendations
- [If AT RISK]: "Consider descoping [lowest priority story] to focus on Must Have items."
- [If BLOCKED]: "Resolve [blocker] to unblock [story name]."
- [If ON TRACK]: "Everything looks good. Keep the pace."
- [If sprint ended]: "Sprint ended [X] days ago. Time to run retrospective and plan next sprint."
```

Phase 6: Offer Next Action

Based on findings:
- If stories are blocked: "Would you like to investigate the blockers now?"
- If sprint is AT RISK: "Should we descope [story name] to protect the Must Haves?"
- If sprint is CRITICAL: "This sprint is unlikely to finish. Recommend: check in with the team, reduce scope, or extend."
- If sprint is ON TRACK: "Sprint looks healthy. Need anything else?"

---

Edge Cases

- No sprint files found: Stop. Don't guess.
- All stories done early: "Sprint complete with [X days] to spare! Want to pull in a Nice-to-Have or start the next sprint?"
- Story not in sprint plan but being worked on: Flag as SCOPE CREEP. "Story [name] is being worked but wasn't in the sprint plan. Is this intentional?"
- Multiple sprints active: Only check the most recent one. "Found multiple sprint plans. Showing latest: Sprint [N]."
