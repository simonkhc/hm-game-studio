# Phase 5: Production

**Goal:** Implement features story by story through structured sprints.

## Pipeline (Repeating)

```
Plan Sprint → Validate Stories → Implement → Story Done → Next Story
                                                   ↓
                                         Sprint Retro → Next Sprint
```

## The Story Lifecycle

### Step 1: Story Readiness

Before implementing, validate the story is ready:
- Design complete (GDD exists, approved)
- Architecture coverage (ADRs exist for affected systems)
- Scope clarity (acceptance criteria testable)
- Dependencies resolved (blocking stories done)

### Step 2: Implementation

1. **Read the design doc** — understand what's specified vs ambiguous
2. **Ask architecture questions** — where does data live? What's the pattern?
3. **Propose approach** — show structure before writing code
4. **Implement** — write testable, data-driven code
5. **Get approval** — "May I write this to [path(s)]?"
6. **Run validation** — tests, linting

### Step 3: Story Done

Load `hm-game-studio/skills/story-done/SKILL.md`:
1. Verify acceptance criteria
2. Check for GDD/ADR deviations
3. Run code review
4. Generate completion report
5. Update story status
6. Surface next ready story

## Sprint Management

### Sprint Plan
- Define sprint goal and duration (1-2 weeks)
- Select stories: Must Have / Should Have / Nice to Have
- Estimate effort (story points or t-shirt sizes)
- Identify risks and blockers

### Sprint Status
Quick snapshot read:
- Stories: planned / in-progress / done / blocked
- Velocity trend
- Blockers

### Retrospective
At sprint end, analyze:
- Planned vs completed
- What went well / what didn't
- Actionable improvements
- Update velocity

## Team Skills (Multi-Agent Features)

For features spanning multiple domains, coordinate specialists:
1. **Design phase** — game-designer asks questions, presents options
2. **Architecture phase** — lead-programmer proposes code structure
3. **Parallel implementation** — specialists work simultaneously via `delegate_task(tasks=[...])`
4. **Integration** — gameplay-programmer wires everything together
5. **Validation** — qa-tester runs against acceptance criteria

## Output Artifacts

| Artifact | Path | Status |
|----------|------|--------|
| Sprint plan | `production/sprints/sprint-[N].md` | Per sprint |
| Story files | `production/epics/[slug]/story-*.md` | Per story |
| Sprint status | `production/sprint-status.yaml` | Living |
| Retrospective | `production/retrospectives/retro-[N].md` | Per sprint |

## Gate Check

Before advancing to Phase 6:
- [ ] All MVP stories complete
- [ ] Playtesting: 3+ sessions
- [ ] Core loop validated as fun
- [ ] No blocking bugs
