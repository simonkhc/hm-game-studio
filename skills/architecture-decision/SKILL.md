name: architecture-decision
description: Create an ADR (Architecture Decision Record) for a significant technical decision. Researches 2-3 options with pros/cons, captures rationale, engine compatibility, GDD requirements, and TR-IDs. Supports retrofit mode for adding sections to existing ADRs.
allowed-tools: read_file, write_file, search_files, clarify
model: sonnet
agent: lead-programmer

Architecture Decision — ADR Authoring

Creates a structured Architecture Decision Record documenting a significant technical choice.
ADR format follows the template at hm-game-studio/templates/ADR-template.md.

Output: docs/architecture/adr-[N]-[slug].md

---

Phase 1: Load Context

Read the relevant GDD(s) for the system being designed.
List existing ADRs: search_files(pattern='adr-*.md', path='docs/architecture/')
Read the ADR template: read_file('hm-game-studio/templates/ADR-template.md')
Read docs/technical-preferences.md for engine version and constraints.

Determine the next ADR number:
- Extract N from existing adr-[N]-*.md files
- Next = max + 1 (or 1 if none exist)

Phase 2: Determine Decision Drivers

Ask the user one question at a time:

2a. "What problem are we solving?"
Guide: "Describe the situation in one paragraph. What's not working with the current approach (or why do we need a new approach)?"

2b. "What constraints exist?"
Probe:
- Engine limitations (specific version APIs that restrict options)
- Platform requirements (what platforms must support this)
- Performance targets (FPS, memory, load time budgets)
- Team constraints (familiarity with certain technologies)
- Timeline constraints (must be done this sprint)

2c. "What are the evaluation criteria?"
Guide: "How will we choose between options? List 3-5 criteria."
Examples:
- Development speed (how fast to implement)
- Runtime performance (CPU/memory impact)
- Maintainability (how easy to change later)
- Testability (how easy to verify correctness)
- Scalability (will it work at full content scale)

Phase 3: Research and Present Options

Present 2-3 technical options. Each option must include:

3a. Summary of approach
One paragraph: what this option involves and how it works.

3b. Pros and cons
| Pro | Con |
|---|---|
| [specific advantage] | [specific disadvantage] |
| [specific advantage] | [specific disadvantage] |

3c. Engine compatibility
Is this option compatible with the pinned engine version?
If post-cutoff: "This engine version (Godot 4.4) may have API differences from my training data (Godot 4.2). Verify the specific API before implementing."

3d. Implementation effort
Estimate: S / M / L / XL (same sizing as sprint-plan)

3e. Risks and mitigation
| Risk | Impact | Mitigation |
|---|---|---|
| [specific risk] | [HIGH/MED/LOW] | [specific mitigation] |

After presentation: "Which option works best for you?"

Phase 4: Capture the Decision

Use clarify if there are clear options.
If the user wants a hybrid approach: capture that as a custom option.
Document the reasoning: why was this option chosen over the alternatives?

If the user says "I don't know enough to decide":
- Research further (web_search for engine-specific guidance)
- Suggest prototyping the top 2 options (small timebox)
- Delegate to an engine specialist (godot-specialist, unity-specialist, etc.)

Phase 5: Write the ADR

Using the template, write to docs/architecture/adr-[N]-[slug].md:

```
# ADR-[N]: [Title]

**Status:** Proposed
**Date:** [YYYY-MM-DD]
**Engine Compatibility:** [engine name + version from technical-preferences.md]

## Context
[The problem we're solving, constraints, and evaluation criteria]

## Decision
[What we decided and why, referencing the chosen option]

## Consequences
### Positive
- [list of benefits]

### Negative
- [list of trade-offs]

## Options Considered
### Option 1: [name]
[Summary, pros/cons, effort estimate]

### Option 2: [name]
[Summary, pros/cons, effort estimate]

## ADR Dependencies
Depends on: [ADR-X if any, or "None"]
Used by: [ADR-Y if any, or "None — no downstream ADRs yet"]

## GDD Requirements Addressed
- [System name from GDD]: [specific requirement]

## Performance Implications
[What performance impact this decision has. Include measurements if available.]
```

Phase 6: Set Status

After writing, ask: "Status is currently 'Proposed'. Ready to set it to 'Accepted'?"
If yes: update Status field. If no: leave as Proposed (user can accept later).

Phase 7: Post-Checks

- ADR has all required sections? (Status, Context, Decision, Consequences, ADR Dependencies, Engine Compatibility, GDD Requirements Addressed)
- ADR number doesn't collide with existing files
- TR registry updated (if the ADR introduces stable requirement IDs)
- File path matches convention: adr-[N]-[slug].md

---

Retrofit Mode (Updating Existing ADRs)

If the user asks to retrofit an existing ADR:
1. Read the existing ADR
2. Identify missing sections
3. For each missing section: ask the user for the content
4. Use patch to add the section
5. Update Status if needed

Special retrofit cases:
- Missing ## Status → check if the decision was actually made. If yes, set to "Accepted"
- Missing ## Engine Compatibility → read technical-preferences.md and add the correct engine version
- Missing ## ADR Dependencies → check other ADRs for references to this ADR
