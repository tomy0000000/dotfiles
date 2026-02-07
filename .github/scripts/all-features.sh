#!/bin/bash
# .github/scripts/all-features.sh
# Outputs all features and their dependencies from Makefile

set -euo pipefail

# Extract features and their dependencies from Makefile
features_with_deps=$(
  { make -prRn -f Makefile : 2>/dev/null || true; } |
    awk '
      function trim(s) {
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", s)
        return s
      }
      function is_valid(name) {
        return !(name == "" || name ~ /^\.|%/ || name ~ /^\//)
      }
      $0 == "# Files" { in_files = 1; next }
      $0 ~ /^# files hash-table stats:/ { in_files = 0 }
      !in_files { next }
      $0 ~ /^# Not a target:/ { skip_next = 1; next }
      /^[^#[:space:]].*:/ {
        line = $0
        if (skip_next) { skip_next = 0; next }
        split(line, parts, ":")
        name = trim(parts[1])
        if (!is_valid(name)) { next }
        deps = trim(substr(line, index(line, ":") + 1))
        gsub(/[[:space:]]+/, " ", deps)
        if (deps == "") {
          print name
          next
        }
        print name " " deps
      }
    ' |
    sort -u
)

# Convert to JSON
features_json=$(
  printf '%s\n' "$features_with_deps" |
    jq -R -s -c '
      split("\n")
      | map(select(length>0))
      | map(
          split(" ")
          | { (.[0]): (.[1:] | map(select(length>0))) }
        )
      | add
    '
)

echo "All features and dependencies:" >&2
echo "$features_with_deps" >&2

# Output to GitHub Actions
echo "features=$features_json" >> "$GITHUB_OUTPUT"

echo $features_json
