# Agent Coordination Map

## Delegation Hierarchy
```
creative-director    technical-director    producer       art-director
       |                    |                 |               |
  game-designer       lead-programmer    release-mgr    technical-artist
  narrative-dir      engine-programmer   qa-lead
  audio-director     network-programmer
  systems-designer   ai-programmer
  economy-designer   ui-programmer
  level-designer     tools-programmer
       |                    |                 |               |
  writer             gameplay-programmer  qa-tester      sound-designer
  world-builder      (all implementation)  devops         performance-analyst
  ux-designer        security-engineer    analytics
  prototyper         accessibility-spec   community-mgr
                     localization-lead    live-ops-designer
```

## Escalation Path
- **Design conflicts:** specialist → lead → creative-director
- **Technical conflicts:** specialist → lead → technical-director
- **Scope conflicts:** anyone → producer
- **QA conflicts:** tester → qa-lead → producer

## File Ownership
| Agent | Owns Files In | Must Not Touch |
|-------|--------------|----------------|
| creative-director | `design/gdd/game-concept.md` | Code files |
| game-designer | `design/gdd/*.md` | Implementation code |
| gameplay-programmer | `src/gameplay/` | Design docs |
| ui-programmer | `src/ui/` | Gameplay logic |
| technical-artist | `assets/shaders/`, `assets/vfx/` | Gameplay code |
| writer | `assets/dialogue/` | Code, design docs |
| qa-tester | `tests/`, `production/bugs/` | Feature code |
