name: create-stories
description: Break epics into implementable story files with acceptance criteria from GDDs. Each story is independent, testable, valued, estimable, small, and testable (INVEST). Validates story readiness: design complete, ADR coverage, testable criteria, dependencies resolved.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: systems-designer

Create Stories — Epic Decomposition

Decomposes an epic into granular, implementable stories.
Each story must pass the INVEST test: Independent, Negotiable, Valuable, Estimable, Small, Testable.

Output: production/epics/[slug]/story-[name].md — one file per story

---

Phase 1: Load Epic Context

Read the epic file from production/epics/[slug]/EPIC.md.
Extract:
- Description and scope
- Systems included (GDD references)
- Dependencies on other epics
- Layer (foundation / core / extended / meta)
- Priority (MVP / Alpha / Full Vision)

Read each referenced GDD for the systems in this epic.
Extract acceptance criteria from each GDD — these become the foundation for story criteria.

Read all ADRs referenced in the epic or GDDs — note architecture constraints.

Phase 2: Decompose System into Stories

For each system in the epic, break into granular stories.

A good story identifies ONE specific behavior change:
- Bad story: "Implement gardening system"
  (Too big. Covers watering, planting, growth, pests — months of work.)
- Good story: "Player can water a plant and see it respond"
  (One behavior. Clear scope. Testable in isolation.)
- Too small: "Add water_drop.png to assets"
  (Trivial. Combine with related work.)

For each potential story, ask these INVEST questions:

1. Independent — Can this story be implemented alone?
   If no: what dependency does it have? Can the dependency be resolved first, or is the story too coupled?
   Acceptable dependencies: "Story B depends on Story A" as long as A is in the same or earlier sprint.

2. Negotiable — Can scope be adjusted without breaking the whole system?
   If no: the story is too rigid. Break it further.
   Example: "Player can water plants (any plant, any time)" can be reduced to "Player can water the first plant in the tutorial" if time runs short.

3. Valuable — Does this deliver player-visible value?
   "Implement database schema for plant data" is NOT valuable alone.
   "Player can see plant names and growth status" IS valuable.
   Infrastructure stories are exceptions — they enable future value. Tag them as INFRASTRUCTURE.

4. Estimable — Can you roughly size this?
   If you can't estimate it, you don't understand it well enough.
   Break down unknowns before creating the story.

5. Small — Can this be done in one sprint (1-2 weeks)?
   If the estimate is XL (5+ days): break it further.
   A sprint should have 3-5 stories, not 1 massive story.

6. Testable — Can you write a test or manual check?
   "Player feels engaged" is NOT testable.
   "The watering animation plays within 200ms of clicking" IS testable.

Each story must pass all 6 checks. If any fails: restructure.

Phase 3: Write Story Files

For each story, write to production/epics/[slug]/story-[story-name].md:

```
# Story: [Short Title]

**Epic:** [epic-slug]
**Status:** Ready
**Priority:** Must Have / Should Have / Nice to Have
**Layer:** Foundation / Core / Extended / Meta
**Points:** [1/3/5/8] (if estimated)

## Description
[One paragraph describing what to implement.
Focus on behavior and player impact, not implementation details.]

## Acceptance Criteria
- [ ] [Criterion 1 — auto-checkable]
- [ ] [Criterion 2 — manual verification]
- [ ] [Criterion 3 — edge case]

### Criterion Types
| Type | Meaning |
| AUTO | Can be verified by automated test |
| MANUAL | Requires human to check |
| DEFERRED | Depends on other stories |

## Technical Notes
- **GDD:** design/gdd/[system].md
- **ADRs:** ADR-[N], ADR-[M]
- **Files affected:** [list of file paths that will be changed]
- **Engine notes:** [any engine-specific considerations]

## Dependencies
- [epic/story-name] — blocking (must be done first)
- [epic/story-name] — informational (may affect approach)

## Test Strategy
- Unit tests: [what functions to test]
- Integration tests: [what system interactions to test]
- Manual tests: [what to verify by hand]
```

Phase 4: Validate Story Coverage

After creating all stories for the epic:

1. Does every acceptance criterion from the GDD map to at least one story?
   If not: create a story for the orphaned criteria.

2. Do the stories, in order, implement the complete system?
   Walk through: if you implement story 1, then 2, then 3... does the system work at the end?
   If there's a gap: create a story for it.

3. Is there a story for each edge case from the GDD?
   Edge cases often get forgotten. Make sure each has a story.

4. Is there at least one INFRASTRUCTURE story for setup work?
   (Config files, data structures, test framework — things that don't deliver player value but enable everything else.)

Phase 5: Validate Story Readiness

For each story, check:

- [ ] Design complete: GDD exists and status is "Approved" or "Designed"
- [ ] Architecture coverage: ADRs exist for any systems touched
- [ ] Scope clear: acceptance criteria are testable (not "should feel good")
- [ ] Dependencies resolved: blocking stories exist and are planned for earlier sprints

Stories that fail readiness checks get status "Draft" instead of "Ready".
Present: "Story [name] can't start yet because [reason]. Should I note the blocking dependency?"

Phase 6: Update Epic

Update the epic file's list of stories:
```
## Stories
- [ ] story-[name1] — [points] — [priority]
- [ ] story-[name2] — [points] — [priority]
```

Phase 7: Post-Checks

- All MVP acceptance criteria from GDDs are covered by stories
- No story depends on another story with LOWER priority in the same epic
- Each story has at least 1 auto-checkable acceptance criterion
- Story files follow the naming convention: production/epics/[slug]/story-[short-name].md
