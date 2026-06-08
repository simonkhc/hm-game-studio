#!/bin/bash
# Session-stop hook: saves state when session ends.
# HMGS equivalent: write current state to production/session-state/active.md.

echo "[HMGS] session stop: saving state..."
# Create session-state directory if it doesn't exist
mkdir -p production/session-state
echo "Session ended at $(date)" >> production/session-state/active.md
