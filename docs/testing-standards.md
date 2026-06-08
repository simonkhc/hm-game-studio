# Testing Standards

## Framework
Use engine-native test frameworks:
- Godot: GUT (Godot Unit Test)
- Unity: Unity Test Framework
- Unreal: Unreal Automation

## Coverage Targets
- Gameplay logic: 90%+ coverage
- Engine code: 80%+ coverage
- UI: Manual verification (automated where practical)

## Test Types
- **Unit tests:** Individual functions and classes
- **Integration tests:** System interactions
- **Smoke tests:** Game boots and runs
- **Regression tests:** Existing functionality unchanged
- **Playtests:** Human testing documented in production/playtests/

## Naming
test_[system]_[behavior].gd or test_[System]_[Behavior].cs
