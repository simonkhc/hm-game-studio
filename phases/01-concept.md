# Phase 1: Concept

**Goal:** Go from "no idea" or "vague idea" to a structured game concept with defined pillars.

## Pipeline

```
Brainstorm → Concept Doc → Setup Engine → Map Systems → Gate Check
```

## Steps

### Step 1: Brainstorm
Load `hm-game-studio/skills/brainstorm/SKILL.md`. Explores ideas interactively:
- **Creative Discovery** — Understand developer's tastes, emotional anchors, constraints
- **Concept Generation** — Generate 3 distinct concepts:
  - Verb-First Design (start from core action)
  - Mashup Method (combine unexpected genres)
  - Experience-First (MDA backward)
- **Core Loop Design** — 30-second, 5-minute, session loops
- **Pillars & Boundaries** — 3-5 pillars + anti-pillars

### Step 2: Concept Document
Write `design/gdd/game-concept.md` with:
- Elevator pitch (one sentence)
- Core fantasy
- MDA breakdown (primary aesthetic targets)
- Target audience (Bartle types, demographics)
- Core loop diagram
- Unique selling proposition
- Comparable titles and differentiation
- Game pillars (3-5) and anti-pillars

### Step 3: Setup Engine
Load `hm-game-studio/skills/setup-engine/SKILL.md`. Configure:
- Engine name and version
- Language
- Naming conventions
- Performance budgets
- Write to `docs/technical-preferences.md`

### Step 4: Map Systems
Load `hm-game-studio/skills/map-systems/SKILL.md`. Create `design/gdd/systems-index.md`:
- Every system the game needs
- Dependencies between systems
- Priority tiers (MVP, Vertical Slice, Alpha, Full Vision)
- Design order (Foundation → Core → Feature → Polish)

## Output Artifacts

| Artifact | Path | Status |
|----------|------|--------|
| Game concept | `design/gdd/game-concept.md` | Required |
| Systems index | `design/gdd/systems-index.md` | Required |
| Tech preferences | `docs/technical-preferences.md` | Required |
| Review mode | `production/review-mode.txt` | Required |

## Gate Check

Before advancing to Phase 2:
- [ ] Concept doc exists with pillars and anti-pillars
- [ ] Systems index exists with dependency ordering
- [ ] Engine configured in technical-preferences.md
- [ ] Review mode set
