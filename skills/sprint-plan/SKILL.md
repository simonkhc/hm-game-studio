name: sprint-plan
description: Plan a sprint — determine duration, select stories (Must Have / Should Have / Nice to Have), estimate effort using t-shirt sizes, identify risks and blockers, write sprint plan document to production/sprints/sprint-[N].md.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: producer

Sprint Plan — Iteration Planning

Plans a single sprint: selects stories from the backlog, estimates them, identifies risks, and creates the sprint document.

This skill assumes stories exist in production/epics/. If they don't, run create-stories first.

Output: production/sprints/sprint-[N].md

---

Phase 1: Determine Sprint Context

1a. Find the next sprint number
Count existing sprint files: search_files(pattern='sprint-*.md', path='production/sprints/')
Next number = max existing + 1 (or 1 if none exist)

1b. Ask about duration
Use clarify:
"How long is this sprint?"
Options:
1. "1 week — fast iteration, good for early development"
2. "2 weeks — standard sprint, balanced for most teams"
3. "Custom — let me specify"

If custom: accept any duration the user provides.

1c. Ask about sprint goal
Ask: "What's the one-sentence goal for this sprint?"
Guide: "A sprint goal should describe the outcome, not the tasks. Example: 'Player can complete the first level' not 'Implement player movement, enemy AI, and level loader'."

If the user struggles: read the MVP systems from systems-index.md and suggest: "The highest priority is [system] — should that be the sprint focus?"

Phase 2: Find Ready Stories

Read all epic files from production/epics/.
For each epic, read all story files.

Classify stories by their Status field:
- READY: Status is "Ready" and all dependencies are done
- IN PROGRESS: Status is "In Progress" (carry-over from previous sprint)
- BLOCKED: Status is "Blocked" (list blockers)
- NOT READY: Status is missing or "Draft" (needs refinement)

Present the pool of READY + IN PROGRESS stories.
If there are fewer than 2 READY stories, flag: "Only [N] ready stories. Consider creating more stories or breaking existing ones into smaller chunks."

Phase 3: Select Stories

Walk through the READY stories with the user.
For each story, ask: "Is this a Must Have, Should Have, or Nice to Have for this sprint?"

| Category | Meaning | How Many |
| Must Have | Sprint fails without these | 3-5 stories |
| Should Have | Important, but can slip to next sprint | 2-3 stories |
| Nice to Have | If time permits | 1-3 stories |

Constraint: total Must Have + Should Have should not exceed team capacity.
If user selects too many: "That's [N] stories — typical sprints handle [M]. Which are truly Must Have?"

Phase 4: Estimate Effort

For each Must Have and Should Have story, estimate using t-shirt sizes:

| Size | Points | Time | What it means |
| S | 1 | 1-2 hours | Known pattern. Simple change. No unknowns. |
| M | 3 | 3-6 hours | Some unknowns, but approach is clear. |
| L | 5 | 1-2 days | Significant work. Multiple files. Integration needed. |
| XL | 8 | 3-5 days | Complex. High unknowns. Touches multiple systems. |

Ask for each story: "Size for [story name]? S/M/L/XL?"
If the user is unsure:
Break the story into smaller tasks and size each one, then sum.

Calculate total sprint load: sum(points for all Must Have + Should Have).
If total > 20 for a 1-week sprint (or > 30 for 2-week): "Total is [N] points, which is above typical capacity. Consider moving [lowest priority story] to Nice to Have."

Phase 5: Identify Risks

For each selected story, ask: "Any risks with this story?"
Common risks to probe:
- "Does this depend on work by someone else?"
- "Any new technology or unfamiliar area?"
- "Does this touch a system we've had bugs in before?"
- "Is there a design decision that's still open?"

Document each risk with a mitigation plan:
| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Third-party API changes | Low | High | Pin API version in config |
| New shader system | Medium | Medium | Prototype first, then implement |

Phase 6: Write Sprint Plan

Write to production/sprints/sprint-[N].md:

```
# Sprint [N]: [Goal]

**Duration:** [start_date] → [end_date] ([N] weeks)
**Total estimate:** [N] points
**Stories:** [N] Must Have, [N] Should Have, [N] Nice to Have

## Sprint Goal
[One-sentence goal]

## Must Have
- [ ] [Story name] ([size]) — [epic]
- [ ] [Story name] ([size]) — [epic]

## Should Have
- [ ] [Story name] ([size]) — [epic]

## Nice to Have
- [ ] [Story name] ([size]) — [epic]

## Carry-Over (In Progress from previous sprint)
- [ ] [Story name] ([size]) — already started

## Risks
- [Risk]: [mitigation]
```

Phase 7: Post-Checks

- All stories have sizes assigned. If any are missing: flag.
- Total sprint load is within reasonable bounds (>40 points for 2 weeks = warning).
- Each Must Have story has at most 1 L or XL — if more, flag as high risk.
- Stories without clear acceptance criteria in their files are noted: "Story [X] lacks acceptance criteria — may cause scope creep."

Ask: "Sprint plan written. Ready to start implementation?"
