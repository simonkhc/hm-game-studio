# Phase 4: Pre-Production

**Goal:** Turn designs into implementable stories. Create UX specs, build a vertical slice, plan the first sprint.

## Pipeline

```
UX Design → Vertical Slice → Create Epics → Create Stories → Sprint Plan → Gate Check
```

## Steps

### Step 1: UX Specs

Create UX specifications for key screens (one per screen):
- Player need — what is the player trying to do?
- Layout zones — key areas of the screen
- States — default, hover, active, disabled, error, empty, loading
- Interaction map — what happens on each interaction
- Data requirements — what data does the screen need?
- Accessibility — keyboard nav, color-blind, screen reader

Write to `design/ux/[screen-name].md`.

### Step 2: Vertical Slice

Build a production-quality end-to-end build proving the core loop is fun:
- One complete [start → challenge → resolution] cycle
- Real architecture (no throwaway code)
- Config files for tunable values
- Minimal placeholder art (functional)

**Verdict:** PROCEED → PIVOT → KILL

### Step 3: Create Epics

Load `hm-game-studio/skills/create-epics/SKILL.md`. Translate GDDs + ADRs into epics.

Each epic in `production/epics/[slug]/EPIC.md`:
- Description and scope
- Dependencies on other epics
- Layer: foundation / core / extended / meta
- Priority: MVP / Alpha / Full Vision

### Step 4: Create Stories

Load `hm-game-studio/skills/create-stories/SKILL.md`. Break each epic into stories.

Each story in `production/epics/[slug]/story-[name].md`:
- Description of behavior to implement
- Acceptance criteria (from GDD)
- ADR references
- Control manifest version

### Step 5: Sprint Plan

Load `hm-game-studio/skills/sprint-plan/SKILL.md`. Plan first sprint:
- Sprint goal and duration
- Must Have / Should Have / Nice to Have stories
- Risks and blockers
- Write to `production/sprints/sprint-01.md`

## Output Artifacts

| Artifact | Path | Status |
|----------|------|--------|
| UX specs | `design/ux/*.md` | Required for key screens |
| Epics | `production/epics/[slug]/EPIC.md` | Required |
| Stories | `production/epics/[slug]/story-*.md` | Required |
| Sprint plan | `production/sprints/sprint-01.md` | Required |
| Vertical slice | `prototypes/vertical-slice/` | Required |

## Gate Check

Before advancing to Phase 5:
- [ ] UX specs exist for key screens
- [ ] Epic and story files exist for MVP features
- [ ] Sprint plan exists
- [ ] Vertical slice built and playtested (3+ sessions)
- [ ] Core loop validated as fun
