name: retrospective
description: Sprint retrospective — analyze what went well, what didn't, and what to change. Quantifies: planned vs completed, mid-sprint additions, blockers, bugs found. Produces actionable improvement plan with assigned owners.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: producer

Retrospective — Sprint Improvement Analysis

At sprint end, analyze results and capture lessons. Not blame — process improvement.
Focus on actionable changes, not complaints.

Output: production/retrospectives/retro-[N].md

---

Phase 1: Identify the Sprint

Search production/sprints/sprint-*.md.
If multiple: find the most recent (highest number).
Read it: extract sprint number, goal, duration, story list with priorities.

If no sprint found: "No sprint to retrospect. Run sprint-plan first." Stop.

---

Phase 2: Gather Data

For each story in the sprint plan, read its story file and check status:
- production/epics/[slug]/story-[name].md → Status field

Count:
- Stories planned: total Must Have + Should Have
- Stories completed: status == "Complete" or "Done"
- Stories in progress: status == "In Progress"
- Stories blocked: status == "Blocked"
- Stories not started: status == "Ready" or "Draft"
- Stories added mid-sprint: stories in the plan that don't have matching backlog entries
  (Cross-check: were all planned stories in the epic backlog before sprint started?)

Calculate:
- Completion rate: (completed / planned) * 100
- Scope change rate: (added_mid_sprint / planned) * 100
  If > 20%: "Scope changed significantly mid-sprint — may indicate planning issues."

---

Phase 3: Ask the Questions

Ask the user these three questions ONE AT A TIME. Do not present as a block.

3a. "What went well this sprint?"
Let the user list freely. Capture every point.
Probe: "Anything else? Even small wins count."
If the user struggles: "What was the best moment this sprint?"

3b. "What didn't go well?"
Let the user list freely. No defensiveness. No justification.
Probe: "What was the biggest time-waster or frustration?"
If the user blames someone: redirect to process. "What about the process allowed that to happen?"

3c. "What should we change next sprint?"
For each problem from 3b, ask: "What's ONE thing we could do differently to prevent this?"
Help turn complaints into actionable changes:
- "We had too many bugs" → "Add bug-bashing day before sprint end"
- "Stories were too big" → "Break stories into smaller chunks (no XL)"
- "Design decisions blocked progress" → "Pre-decide designs before sprint starts"

---

Phase 4: Quantify

Calculate and compile:
- Planned stories: [N]
- Completed stories: [M] ([P]%)
- Stories added mid-sprint: [N]
- Stories blocked: [N] — reasons: [list]
- Bugs filed during sprint: [N]
- Average story size: [small/medium/large — if sized]

Trend check (if previous retrospectives exist):
- Read previous retro files for velocity numbers
- Compare: is velocity trending up, down, or flat?
- If trending down: investigate root cause

---

Phase 5: Write Retrospective

Write to production/retrospectives/retro-[N].md:

```
# Sprint [N] Retrospective

**Date:** [YYYY-MM-DD]
**Sprint goal:** [goal]

## Numbers
- Planned: [N] ([Must Have], [Should Have], [Nice to Have])
- Completed: [M] ([P]%)
- Added mid-sprint: [N]
- Blocked: [N]
- Bugs filed: [N]

## What Went Well
- [Item 1]
- [Item 2]

## What Didn't Go Well
- [Item 1]
- [Item 2]

## Action Items
- [ ] [Actionable change] — [owner]
- [ ] [Actionable change] — [owner]
```

---

Phase 6: Post-Checks

- Retrospective captures all three questions, not just "what went wrong"
- Action items are specific (not "communicate better" — "add daily 5-min standup at 10am")
- Each action item has an owner (or "team" if shared)
- Ask: "Should I apply any of these action items to the next sprint plan?"
  If yes: read the next sprint plan, add action items as stories or notes.

---

Edge Cases

- Sprint had ZERO completed stories: Don't treat as failure. Ask: "Was the scope too large? Were there unexpected blockers? Should the next sprint be smaller?"
- User is unhappy with sprint result: Acknowledge. "It was a tough sprint. Let's focus on what we can control for next sprint."
- Retro keeps producing same action items: The items aren't being implemented. Ask: "These items appeared last retro too. What's blocking them?"

---

Edge Cases

- No stories were planned (ad-hoc sprint): Retro is still useful. "Was the sprint focused? Did we accomplish what we wanted?"
- Team of one: Action items are still valid. "Even solo devs can improve process."
- Sprint was interrupted (holiday, emergency): Note the interruption. "Effective sprint was only [N] days. Adjust velocity for next sprint."
- User can't think of anything that went well: Probe harder. "What about that moment when [story] finally worked? That's a win."
