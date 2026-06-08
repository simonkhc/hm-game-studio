# Hermes Game Studio — Skill Testing Framework

Quality assurance infrastructure for the HMGS framework itself.
Tests the skills and agents — not any game built with them.

> **Optional.** Game developers don't need this.

## What's Inside

```
skill-testing/
├── README.md
├── catalog.yaml
├── quality-rubric.md
├── templates/
│   ├── workflow-test-spec.md
│   └── agent-test-spec.md
└── results/           # Test run outputs (gitignored)
```

## How to Use

### Check structural compliance
```
skill-view hmgs-skill-test → run static checks on a skill
```

### Run a behavioral spec test
```
skill-view hmgs-skill-test → evaluate a skill against its written spec
```

### Check against category rubric
```
skill-view hmgs-skill-test → run rubric checks across categorized skills
```

## Categories

| Category | Skills | Key Metrics |
|----------|--------|-------------|
| gate | gate-check | Review mode read, no auto-advance |
| review | design-review, code-review, architecture-review | Read-only, correct verdicts |
| authoring | design-system, quick-design, architecture-decision | Section-by-section, may-I-write |
| pipeline | create-epics, create-stories, map-systems | Dependency check, handoff clear |
| analysis | balance-check, code-review, tech-debt | Read-only report, verdict keyword |
| team | team-combat, team-narrative, team-ui | All required delegates surfaced |
| sprint | sprint-plan, sprint-status, milestone-review | Reads sprint data, status keywords |
| utility | start, adopt, hotfix, setup-engine | Passes static checks |
