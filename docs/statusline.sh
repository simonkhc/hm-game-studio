#!/bin/bash
# Statusline — Terminal status display for HMGS projects
# Displays current phase, review mode, and key metrics.
# Source this file in your .bashrc or .zshrc: source docs/statusline.sh

hmgs_status() {
    local stage_file="production/stage.txt"
    local review_file="production/review-mode.txt"
    local gdd_count=$(ls design/gdd/*.md 2>/dev/null | wc -l)
    local adr_count=$(ls docs/architecture/adr-*.md 2>/dev/null | wc -l)
    local story_count=$(find production/epics -name "story-*.md" 2>/dev/null | wc -l)
    local src_count=$(find src -name "*.gd" -o -name "*.cs" -o -name "*.cpp" 2>/dev/null | wc -l)
    
    local stage="(no stage)"
    local review="(no mode)"
    
    if [ -f "$stage_file" ]; then
        stage=$(cat "$stage_file")
    fi
    if [ -f "$review_file" ]; then
        review=$(cat "$review_file")
    fi
    
    echo " HMGS [$stage|$review] GDDs:$gdd_count ADRs:$adr_count Stories:$story_count Files:$src_count "
}

# Uncomment to add to your prompt:
# PS1="\$PS1\$(hmgs_status)\n"
