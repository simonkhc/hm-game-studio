name: perf-profile
description: Profile the game and identify performance bottlenecks — CPU frame budget, GPU draw calls, memory usage, texture VRAM, load times. Reads performance targets from technical-preferences.md. Reports findings with specific, actionable optimization recommendations. Does NOT modify files.
allowed-tools: read_file, search_files, write_file, terminal, clarify
model: sonnet
agent: performance-analyst

Performance Profile — Bottleneck Analysis

Profiles the game to identify where performance budget is being spent. Uses engine profilers when available, heuristics when not.
The goal is specific, actionable optimization tasks — not "make it faster" but "reduce draw calls from 150 to 50 by batching these 3 materials."

Output: docs/performance/profile-[date].md

---

Phase 1: Establish Targets

Read docs/technical-preferences.md for performance budgets:
- Target FPS: (30 for slow-paced, 60 for action, 144 for competitive)
- Memory budget: (platform-dependent — 2GB for desktop, 512MB for mobile)
- Load time max: (seconds — 5s for desktop, 15s for mobile)
- Draw call budget: (100 for mobile, 1000 for desktop)

If the file doesn't exist or has [TO BE CONFIGURED] values, ask the user:
- "What's the target FPS?" (default: 60)
- "What's the memory budget?" (default: "2GB for desktop, 512MB for mobile")
- "What's the acceptable load time?" (default: "5 seconds")

Record targets at the top of the report.

---

Phase 2: CPU Profile

2a. Script/component count
Count active scripts per frame:
- Godot: search_files(pattern='.gd', path='src/') — count files
  Warning: >100 active _process() calls = investigate
- Unity: count MonoBehaviours with Update() methods
  Warning: >200 active Update() calls = investigate
- Unreal: count Tick() overrides
  Warning: >100 active Ticks = investigate

2b. Physics objects
Search for physics components:
- Godot: search_files(pattern='RigidBody|CharacterBody|Area', path='src/')
- Unity: search_files(pattern='Rigidbody|Collider', path='Assets/')
- Unreal: search for UPrimitiveComponent subclasses
Warning: >50 physics bodies active simultaneously = investigate

2c. Object pooling check
If the game spawns/destroys objects frequently (projectiles, particles, enemies):
- Search for Instantiate/Destroy (Unity), instance/queue_free (Godot), SpawnActor/DestroyActor (Unreal)
- If spawning in hot paths (every frame, every input): "Allocation in hot path detected. Consider object pooling."
- Count how many unique objects are instantiated: if > 1000 unique prefabs, memory fragmentation risk.

---

Phase 3: GPU Profile

3a. Renderer check
Read project settings for the renderer:
- Godot: project.godot → rendering/rendering_method (gl_compatibility / mobile / forward_plus)
- gl_compatibility: OK for 2D, limited 3D
- mobile: balanced for mobile 3D
- forward_plus: best quality, highest GPU cost

3b. Draw call estimation
Estimate draw calls from materials and meshes:
- Count unique materials in project: search for material/shader files
- Count unique meshes: search for mesh/model files
- Estimated draw calls ≈ unique_materials × unique_meshes (rough)
- Actual draw calls depend on batching
- If project has >50 unique materials: investigate material consolidation

3c. Texture memory estimation
Search for texture files (.png, .jpg, .exr):
- For each texture: estimate VRAM = width × height × 4 bytes (RGBA32)
  Example: 2048×2048 texture = 16MB in VRAM
- Sum all estimates
- If total > 1GB: "Texture memory may exceed budget. Consider texture atlasing or compression."
- List the top 5 largest textures by estimated VRAM usage

3d. Overdraw potential
If the game has multiple overlapping transparent layers (particles, UI, translucent objects):
- Search for transparent shaders, alpha-blended materials
- Each transparent layer = full-screen pass = expensive
- If more than 3 transparent layers can overlap: "Potential overdraw issue. Consider reducing transparent layer count."

---

Phase 4: Memory Profile

4a. Asset memory
- Total unique assets loaded at once: estimate from scene complexity
- If individual scenes load > 50 unique resources: "Consider async loading or streaming."

4b. Memory leaks
Search for patterns that cause leaks:
- Event/subscriber patterns not unsubscribed: search for .connect() without .disconnect()
- File handles not closed: search for FileAccess.open() without close()
- Singletons holding object references: search for static/autoload variables

4c. Save file size
If the game has persistent state:
- Estimate max save file size from data model
- If > 10MB: "Save file is large. Consider incremental saves."

---

Phase 5: Load Time Analysis

5a. Scene complexity
For the main/entry scenes:
- Count child nodes in the scene tree
- If > 500 nodes in a single scene: "Scene is too large. Split into sub-scenes loaded on demand."

5b. Resource loading
Check if resources are loaded:
- At boot (slow startup but smooth gameplay)
- On demand (fast startup but possible hitching during play)
- If the game has no loading screen and loads > 100 resources at boot: "Add a loading screen or stagger loading."

---

Phase 6: Write Report

Write to docs/performance/profile-[date].md:

```
# Performance Profile: [date]

**Targets:** [FPS] FPS, [memory] MB RAM, [loadtime]s max load

## CPU
- Active scripts: [N] — [OK / WARN / HIGH]
- Physics bodies: [N] — [OK / WARN / HIGH]
- Hot path allocations: [YES / NO] — [details if yes]
- Object pooling: [USED / NOT USED / N/A]

## GPU
- Renderer: [type]
- Estimated draw calls: [N]
- Texture VRAM: [N] MB — [OK / WARN / HIGH]
- Transparent layers: [N] — [OK / WARN]

## Memory
- Assets per scene: [N] avg — [OK / WARN]
- Potential leaks: [N] sites — [list top patterns]
- Save file estimate: [N] MB — [OK / WARN]

## Recommendations
1. [▰▰▰ HIGH] [specific action] — [expected improvement]
2. [▰▰ MEDIUM] [specific action] — [expected improvement]
3. [▰ LOW] [specific action] — [expected improvement]
```

---

Phase 7: Post-Checks

- Report written to docs/performance/
- Recommendations are SPECIFIC (file paths, line numbers, expected improvement)
- Ask: "Should I implement any of the HIGH priority recommendations now?"
- If yes: create a story for each HIGH optimization task.

---

Edge Cases

- No profiler available: Use heuristics and manual code review. Report: "No profiler data — analysis is approximate."
- Game hasn't been built yet: "Can't profile a build that doesn't exist. Build first, then profile."
- Frame rate target conflicts with design (e.g., slow-paced game targeting 144 FPS): "Target FPS should match the gameplay pace. 30 FPS is acceptable for slow-paced games."
