#!/bin/bash
# .github/scripts/feature-list.sh
# Generates feature list from changed file paths

set -euo pipefail

# Read changed paths from first argument
if [ $# -lt 1 ]; then
  echo "Usage: $0 <changed_paths>" >&2
  exit 1
fi

changed_paths="$1"

# Extract feature names for any changed file under pkg/some-feature/*
changed_features=$(
  printf '%s\n' "$changed_paths" |
    sed -n 's|^pkg/\([^/]*\).*|\1|p' |
    sort -u
)

echo "Changed features from pkg/:" >&2
echo "$changed_features" >&2

# Convert to JSON array
features_json=$(
  printf '%s\n' "$changed_features" |
    jq -R -s -c 'split("\n") | map(select(length>0))'
)

# Output to GitHub Actions
echo "features=$features_json" >> "$GITHUB_OUTPUT"
