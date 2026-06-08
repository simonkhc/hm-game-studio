# Phase 3: Technical Setup

**Goal:** Make key technical decisions, document as ADRs, validate through review, produce control manifest.

## Pipeline

```
Create Architecture → ADRs → Architecture Review → Control Manifest → Gate Check
```

## Steps

### Step 1: Architecture Document

Create `docs/architecture/architecture.md`:
- System boundaries and responsibilities
- Data flow between systems
- Integration points
- Engine architecture alignment

### Step 2: ADRs (Architecture Decision Records)

For each significant technical decision, load `hm-game-studio/skills/architecture-decision/SKILL.md`:

**Minimum required ADRs:**
- Project structure and organization
- Scene/state management
- Data persistence (save/load)
- Dependency injection or service locator

**ADR lifecycle:** Proposed → Accepted → Superseded/Deprecated

### Step 3: Architecture Review

Load `hm-game-studio/skills/architecture-review/SKILL.md`:
- Topological sort of ADR dependencies
- Engine compatibility verification
- GDD alignment checks
- TR-ID registry maintenance

### Step 4: Control Manifest

Load `hm-game-studio/skills/create-control-manifest/SKILL.md`. Create `docs/architecture/control-manifest.md`:
- Required patterns
- Forbidden patterns
- Guardrails per layer

### Step 5: Accessibility Requirements

Create `design/accessibility-requirements.md`:
- Commit to a tier: Basic / Standard / Comprehensive / Exemplary
- Fill the 4-axis feature matrix: Visual, Motor, Cognitive, Auditory

## Output Artifacts

| Artifact | Path | Status |
|----------|------|--------|
| Architecture doc | `docs/architecture/architecture.md` | Required |
| ADRs | `docs/architecture/adr-*.md` | Required (3+) |
| Architecture review | `docs/architecture/architecture-review-[date].md` | Required |
| Control manifest | `docs/architecture/control-manifest.md` | Required |
| Accessibility requirements | `design/accessibility-requirements.md` | Required |

## Gate Check

Before advancing to Phase 4:
- [ ] Architecture document exists
- [ ] At least 3 ADRs exist and are Accepted
- [ ] Architecture review completed (PASS or CONCERNS)
- [ ] Control manifest exists
- [ ] Accessibility requirements committed
