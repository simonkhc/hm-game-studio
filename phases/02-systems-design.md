# Phase 2: Systems Design

**Goal:** Create complete GDDs for every system identified in the systems index.

## Pipeline

```
Design System → Review GDD → Next System → Cross-GDD Review → Gate Check
```

## Steps

### Step 1: Author System GDDs

For each system (in dependency order), create a GDD with all 8 required sections:

1. **Overview** — One-paragraph summary
2. **Player Fantasy** — What the player imagines/feels
3. **Detailed Rules** — Unambiguous mechanical rules
4. **Formulas** — Calculations with variable definitions
5. **Edge Cases** — Explicitly resolved weird situations
6. **Dependencies** — Connected systems (bidirectional)
7. **Tuning Knobs** — Configurable values with safe ranges
8. **Acceptance Criteria** — Testable completion conditions

**Process per GDD:**
1. Read `hm-game-studio/skills/design-system/SKILL.md`
2. Load upstream GDDs for context
3. Walk through sections interactively (question → options → decide → draft → write)
4. Write each section immediately after approval
5. Run `hm-game-studio/skills/design-review/SKILL.md` after completion

### Step 2: Quick Design

For small changes that don't warrant a full GDD, create a lightweight spec in `design/quick-specs/`:
- What changed
- Why
- Impact on other systems
- Before/after values

### Step 3: Cross-GDD Review

After all MVP GDDs are approved individually, run cross-GDD review:

**Consistency checks:**
- Dependency bidirectionality
- Rule contradictions between systems
- Formula range compatibility
- Naming consistency

**Design theory checks:**
- Competing progression loops
- Cognitive load (max 4 active systems at once)
- Dominant strategies
- Economic loop analysis
- Pillar alignment

## Output Artifacts

| Artifact | Path | Status |
|----------|------|--------|
| System GDDs | `design/gdd/[system-name].md` | Required per system |
| Cross-GDD review | `design/gdd/cross-review-[date].md` | Required |

## Gate Check

Before advancing to Phase 3:
- [ ] All MVP systems have Status: Approved
- [ ] Each MVP system has a reviewed GDD with 8 sections
- [ ] Cross-GDD review completed (PASS or CONCERNS)
