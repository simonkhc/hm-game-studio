# Lead Programmer — Persistent Memory

**Last updated:** [YYYY-MM-DD]
**Purpose:** Persistent context that survives across sessions. Read this before delegating to lead-programmer agent.

## Project Architecture Decisions
- Key ADRs affecting current implementation
- Engine-specific idioms to follow
- Current architecture patterns used

## Technical Standards
- Data-driven design: all tunable values in config files
- No magic numbers (except 0, 1, -1, 100)
- Signals/events over direct coupling
- Dependency injection over singletons
- Tests for all gameplay logic

## Known Technical Debt
- [List of open tech debt items from the register]

## Performance Targets
- Target FPS: [from technical-preferences.md]
- Draw call budget: [if applicable]
- Memory budget: [from technical-preferences.md]

## Notes
- This file is updated after each architecture review or significant technical decision.
- Outdated information should be corrected, not tolerated.
