# Director Gates — Shared Review Pattern

**Adapted from CCGS** — Defines standard gate prompts for all director and lead reviews across every skill stage.

## Review Modes

Review intensity controls whether director gates run:

| Mode | What runs | Best for |
|------|-----------|----------|
| `full` | All gates active | Teams, learning users |
| `lean` | PHASE-GATEs only | **Default** — solo devs |
| `solo` | No gates | Game jams, prototypes |

**Check pattern:**
```
Before running any gate:
1. If user specified --review [mode], use that
2. Else read production/review-mode.txt
3. Else default to lean
```

## Standard Verdict Format

| Verdict | Meaning | Default action |
|---------|---------|----------------|
| **APPROVE / READY** | No issues | Continue |
| **CONCERNS** | Non-blocking issues | Surface to user via clarify() |
| **REJECT / NOT READY** | Blocking issues | Do not proceed until resolved |

## Gate Definitions

### CD-PILLARS — Pillar Stress Test
**Agent:** creative-director | **Trigger:** After pillars defined
**Context:** Full pillar set, anti-pillars, core fantasy, unique hook
**Prompt:** Review pillars for falsifiability, tension, differentiation.

### CD-GDD-ALIGN — GDD Pillar Alignment
**Agent:** creative-director | **Trigger:** After GDD authored
**Context:** GDD path, game pillars, MDA targets
**Prompt:** Review GDD for pillar alignment. Does every section serve the pillars?

### CD-PHASE-GATE — Creative Phase Gate
**Agent:** creative-director | **Trigger:** At gate-check
**Prompt:** Review project state for phase readiness from creative perspective.

### TD-ARCHITECTURE — Architecture Soundness
**Agent:** technical-director | **Trigger:** After architecture defined
**Prompt:** Review architecture for clarity, engine alignment, testability.

### TD-PHASE-GATE — Technical Phase Gate
**Agent:** technical-director | **Trigger:** At gate-check
**Prompt:** Review technical readiness. Are there architectural risks?

### PR-SPRINT — Sprint Feasibility
**Agent:** producer | **Trigger:** After sprint plan
**Prompt:** Is the sprint achievable? Risks? Dependencies?

### PR-PHASE-GATE — Production Phase Gate
**Agent:** producer | **Trigger:** At gate-check
**Prompt:** Review schedule, scope, and risk readiness.

### QL-STORY-READY — Story Readiness
**Agent:** qa-lead | **Trigger:** Before story implementation
**Prompt:** Is the story well-defined? Testable? Acceptance criteria clear?
