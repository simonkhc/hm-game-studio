# Hooks Reference

CCGS used auto-triggered bash hooks (pre-tool, post-compact, session-start, etc.).
Hermes does not have automatic hooks. Instead, equivalent checks are embedded in each skill.

## Skill-Embedded Checks

| CCGS Hook | HMGS Equivalent |
|-----------|----------------|
| pre-tool.sh | Skill pre-conditions (check files exist before starting) |
| post-compact.sh | Not needed — Hermes manages context automatically |
| session-start.sh | Read production/stage.txt + production/session-state/active.md |
| session-stop.sh | Write production/session-state/active.md with last state |
| detect-gaps.sh | Built into project-stage-detect and adopt skills |
| pre-commit.sh | Built into story-done skill (acceptance criteria verification) |

## Manual Equivalents

When starting a session:
1. Read production/stage.txt → current phase
2. Read production/session-state/active.md → where you left off
3. Use session_search → find relevant past context

When ending a session:
1. Write production/session-state/active.md → current state
2. Update production/stage.txt if phase changed
