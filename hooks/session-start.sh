#!/bin/bash
# Session-start hook: runs when a new session begins.
# HMGS equivalent: read production/stage.txt + production/session-state/active.md.

echo "[HMGS] session start: detecting project state..."
if [ -f "production/stage.txt" ]; then
    echo "Current phase: $(cat production/stage.txt)"
fi
if [ -f "production/session-state/active.md" ]; then
    echo "Previous session state found. Run 'cat production/session-state/active.md' to review."
fi
