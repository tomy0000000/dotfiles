#!/bin/bash
# .github/scripts/changed-files.sh
# Outputs changed files between base and head commits for GitHub Actions

set -euo pipefail

# Read GitHub context from first argument
if [ $# -lt 1 ]; then
  echo "Usage: $0 <github_context_json>" >&2
  exit 1
fi

GITHUB_CONTEXT="$1"

# Parse event information using jq
event_name=$(echo "$GITHUB_CONTEXT" | jq -r '.event_name')

# Determine base and head commits based on event type
if [ "$event_name" = "pull_request" ]; then
  base=$(echo "$GITHUB_CONTEXT" | jq -r '.event.pull_request.base.sha')
  head=$(echo "$GITHUB_CONTEXT" | jq -r '.event.pull_request.head.sha')
elif [ "$event_name" = "push" ]; then
  base=$(echo "$GITHUB_CONTEXT" | jq -r '.event.before')
  head=$(echo "$GITHUB_CONTEXT" | jq -r '.sha')
else
  echo "Unsupported event: $event_name" >&2
  base=""
  head=""
fi

# Check if we have valid base and head commits
if [ -z "$base" ] || [ -z "$head" ] || [ "$base" = "null" ] || [ "$head" = "null" ]; then
  echo "No base/head to diff; leaving paths empty." >&2
  echo "paths=" >> "$GITHUB_OUTPUT"
  exit 0
fi

# Get changed files using git diff
files=$(git diff --name-only "$base" "$head" || true)

echo "Changed files:" >&2
echo "$files" >&2

# Output to GitHub Actions
{
  echo 'paths<<EOF'
  echo "$files"
  echo 'EOF'
} >> "$GITHUB_OUTPUT"
