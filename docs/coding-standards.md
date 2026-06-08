# Coding Standards

## Gameplay Code (`src/gameplay/`)
- ALL gameplay values MUST come from external config/data files, NEVER hardcoded
- Use delta time for ALL time-dependent calculations
- NO direct references to UI code — use events/signals
- Every gameplay system must implement a clear interface
- State machines must have explicit transition tables
- Write unit tests for all gameplay logic
- No static singletons for game state — use dependency injection

## Engine Code (`src/core/`)
- Zero allocations in hot paths (update loops, physics callbacks)
- Thread safety for any shared state
- Stable public API with deprecation path
- Document performance characteristics of public functions

## AI Code (`src/ai/`)
- Performance budgets: max N active AI updates per frame
- Debug visualization for all AI decision-making
- Data-driven parameters (behavior weights, thresholds)
- No direct references to gameplay code — use blackboard/events

## Network Code (`src/networking/`)
- Server-authoritative for all critical state
- Versioned network messages (no silent breakage)
- Security: validate all inputs server-side
- Bandwidth budgets per message type

## UI Code (`src/ui/`)
- No game state ownership — UI displays, it doesn't decide
- Localization-ready: all strings via localization system
- Accessibility: keyboard navigable, screen reader compatible
- Responsive to different aspect ratios and resolutions

## Data Files (`assets/data/`)
- JSON format for all configurable data
- Document all fields with comments or schema
- Version the schema for migration support

## Tests (`tests/`)
- Naming: `test_[system]_[behavior].gd`
- Coverage: all gameplay logic, all edge cases
- Unit tests for isolated logic, integration tests for system interactions
- Manual playtests documented in `production/playtests/`

## Prototypes (`prototypes/`)
- Relaxed standards — speed over quality
- README required: what was tested, what was learned, next steps
- Hypothesis documented before building
