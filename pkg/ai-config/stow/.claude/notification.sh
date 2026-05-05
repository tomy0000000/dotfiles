#!/bin/bash
input=$(cat)

session=$(echo "$input" | jq -r '.session_id // ""')
cwd=$(echo "$input" | jq -r '.cwd // ""')

short=${session:0:8}
base=${cwd##*/}

osascript -e "display notification \"Session ${short} at ${base} needs your attention\" with title \"Claude Code\""