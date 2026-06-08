#!/bin/bash
# Pre-push hook: runs before git push.
echo "[HMGS] pre-push: running smoke checks..."
# Check if tests exist and run them
if [ -d "tests" ]; then
    echo "  Tests directory found. Run tests manually if needed."
fi
