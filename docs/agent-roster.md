# Hermes Game Studio — Agent Roster

All 49 agents available in the framework. Each has a dedicated prompt file in `agents/`.
Use with `delegate_task()` — pass the prompt text as `context` parameter.

## Tier 1 — Directors (strategic oversight)

| Agent | Domain | When to Use |
|-------|--------|-------------|
| `creative-director` | Vision, pillars | Major creative decisions, pillar conflicts, tone |
| `technical-director` | Architecture, tech stack | Architecture decisions, performance strategy |
| `producer` | Schedule, scope, process | Sprint planning, milestone tracking, risk management |
| `art-director` | Visual direction | Style guides, art bible, asset standards |

## Tier 2 — Leads (domain ownership)

| Agent | Domain | When to Use |
|-------|--------|-------------|
| `game-designer` | Mechanics, systems | Core loop, progression, economy, balancing |
| `lead-programmer` | Code architecture | System design, code review, API design |
| `narrative-director` | Story, writing | Story arcs, world-building, dialogue strategy |
| `audio-director` | Audio direction | Music direction, sound palette, audio strategy |
| `qa-lead` | Quality assurance | Test strategy, bug triage, release readiness |
| `release-manager` | Release pipeline | Build management, versioning, deployment |
| `localization-lead` | Internationalization | String externalization, translation pipeline |
| `systems-designer` | System design | Specific mechanic implementation, formula design |
| `level-designer` | Level design | Level layouts, pacing, encounter design |
| `economy-designer` | Economy/balance | Resource economies, loot tables, progression |

## Tier 3 — Specialists (execution)

| Agent | Domain | When to Use |
|-------|--------|-------------|
| `gameplay-programmer` | Gameplay code | Feature implementation, gameplay systems |
| `engine-programmer` | Engine systems | Core engine, rendering, physics, memory |
| `ai-programmer` | AI systems | Behavior trees, pathfinding, NPC logic |
| `network-programmer` | Networking | Netcode, replication, lag compensation |
| `tools-programmer` | Dev tools | Editor extensions, pipeline tools |
| `ui-programmer` | UI implementation | UI framework, screens, data binding |
| `technical-artist` | Tech art | Shaders, VFX, optimization, art pipeline |
| `sound-designer` | Sound design | SFX design docs, audio event lists |
| `writer` | Dialogue/lore | Dialogue writing, lore entries, descriptions |
| `world-builder` | World/lore design | World rules, faction design, history |
| `ux-designer` | UX flows | User flows, wireframes, accessibility |
| `prototyper` | Rapid prototyping | Throwaway prototypes, mechanic testing |
| `performance-analyst` | Performance | Profiling, optimization, memory analysis |
| `qa-tester` | Test execution | Test cases, bug reports, checklists |
| `devops-engineer` | Build/deploy | CI/CD, build scripts, version control |
| `analytics-engineer` | Telemetry | Event tracking, dashboards, A/B tests |
| `security-engineer` | Security | Anti-cheat, exploit prevention, save encryption |
| `accessibility-specialist` | Accessibility | WCAG compliance, colorblind modes |
| `live-ops-designer` | Live operations | Seasons, events, battle passes, retention |
| `community-manager` | Community | Patch notes, player feedback, crisis comms |

## Engine Specialists

### Godot 4

| Agent | Subsystem |
|-------|-----------|
| `godot-specialist` | General Godot architecture |
| `godot-gdscript` | GDScript patterns and performance |
| `godot-shader` | Shaders and rendering |
| `godot-gdextension` | GDExtension C++/Rust bindings |

### Unity

| Agent | Subsystem |
|-------|-----------|
| `unity-specialist` | General Unity architecture |
| `unity-dots` | DOTS/ECS |
| `unity-shader` | Shaders/VFX |
| `unity-addressables` | Asset management |
| `unity-ui` | UI Toolkit/UGUI |

### Unreal Engine 5

| Agent | Subsystem |
|-------|-----------|
| `unreal-specialist` | General Unreal architecture |
| `ue-gas` | Gameplay Ability System |
| `ue-blueprint` | Blueprint architecture |
| `ue-replication` | Networking/Replication |
| `ue-umg` | UMG/CommonUI |
