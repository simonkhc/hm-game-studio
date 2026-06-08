#!/bin/bash
# Pre-commit hook: runs before git commit.
# HMGS equivalent: story-done skill verifies acceptance criteria.

echo "[HMGS] pre-commit: checking commit readiness..."
# Check for debug print statements
if grep -rn "print\|debug\|console.log" src/ --include="*.gd" --include="*.cs" 2>/dev/null | grep -v "print_debug\|#"; then
    echo "  Warning: Debug statements found in staged files."
fi
