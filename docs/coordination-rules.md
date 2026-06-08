# Coordination Rules

**Adapted from CCGS for Hermes Agent**

## Delegation Rules

1. **Vertical Delegation**: Directors delegate to leads, leads delegate to specialists. Never skip tiers for complex decisions.
2. **Horizontal Consultation**: Same-tier agents may consult each other but must not make binding decisions outside their domain.
3. **Conflict Resolution**: Design conflicts escalate to `creative-director`. Technical conflicts escalate to `technical-director`. Scope conflicts escalate to `producer`.
4. **Change Propagation**: When a design change affects multiple domains, `producer` coordinates the propagation.
5. **No Unilateral Cross-Domain Changes**: Agents must not modify files outside their designated directories without explicit delegation.

## Parallel Task Protocol

When orchestrating multiple agents via `delegate_task(tasks=[...])`:

1. Issue all independent tasks before waiting for any result
2. Collect all results before proceeding to dependent phases
3. If any agent is BLOCKED, surface it immediately — do not silently skip
4. Always produce a partial report if some agents complete and others block

## Domain Boundaries

| Agent | Owns | Does NOT Own |
|-------|------|-------------|
| game-designer | How the game works | How it's implemented |
| gameplay-programmer | How features are coded | What the features do |
| lead-programmer | Code architecture | Game design decisions |
| creative-director | Creative vision | Technical implementation |
| technical-director | Technical strategy | Creative direction |
| producer | Schedule and process | Design or tech specifics |

## Escalation Path

```
gameplay-programmer → lead-programmer → technical-director
game-designer → creative-director
sound-designer → audio-director → creative-director
writer → narrative-director → creative-director
qa-tester → qa-lead → producer
```
