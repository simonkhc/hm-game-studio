# Engine Code Rules
Applies to: src/core/, src/engine/

1. Zero allocations in hot paths (update loops, physics callbacks)
2. Thread safety for any shared state
3. Stable public API with deprecation path
4. Document performance characteristics of public functions
