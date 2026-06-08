# Brownfield Adoption

## When to Use This
You have an existing game project with code and want to adopt HMGS.

## Process

### Step 1: Run Adopt Skill
Read hm-game-studio/skills/adopt/SKILL.md

### Step 2: Audit Existing Artifacts
The adopt skill scans for design docs, ADRs, stories, code — checks format compliance.

### Step 3: Set Review Mode
production/review-mode.txt → full (initially stricter for brownfield)

### Step 4: Phase Detection
Run project-stage-detect to determine current phase.

### Step 5: Gap Fill
Priority: BLOCKING → HIGH → MEDIUM → LOW

### Step 6: Normal Framework Usage
Once blocking gaps are filled, use the framework normally.
