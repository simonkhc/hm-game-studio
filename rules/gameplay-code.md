# Gameplay Code Rules
Applies to: src/gameplay/

1. ALL gameplay values MUST come from config files (assets/data/), NEVER hardcoded
2. Use delta time for ALL time-dependent calculations
3. NO direct references to UI code — use events/signals
4. Every gameplay system must implement a clear interface
5. State machines must have explicit transition tables
6. Write unit tests for all gameplay logic
7. No static singletons for game state — use dependency injection
