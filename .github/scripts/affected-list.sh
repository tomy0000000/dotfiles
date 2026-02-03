#!/bin/bash
# .github/scripts/affected-list.sh
# infer all affected features based on a list of changed features

set -euo pipefail

# Read changed features JSON array from first argument
if [ $# -lt 1 ]; then
  echo "Usage: $0 <changed_features_json>" >&2
  exit 1
fi

features_json="$1"

if [ -z "$features_json" ] || [ "$features_json" = "null" ]; then
  features_json="[]"
fi

if ! echo "$features_json" | jq -e '.' >/dev/null 2>&1; then
  echo "Invalid JSON for changed features." >&2
  exit 1
fi

# mapfile -t changed_features < <(echo "$features_json" | jq -r '.[]')

# declare -A seen
# affected_features=()

# add_feature() {
#   local feature="$1"
#   if [ -n "$feature" ] && [ -z "${seen[$feature]+x}" ]; then
#     affected_features+=("$feature")
#     seen["$feature"]=1
#   fi
# }

# for feature in "${changed_features[@]}"; do
#   add_feature "$feature"
#   case "$feature" in
#     brew)
#       add_feature "macos-brew"
#       ;;
#     shellcheck)
#       add_feature "macos-shellcheck"
#       ;;
#     sublime)
#       add_feature "macos-sublime"
#       ;;
#     vscode)
#       add_feature "macos-vscode"
#       ;;
#     perl)
#       add_feature "macos-perl"
#       ;;
#     macos-services)
#       add_feature "macos-service-workflow"
#       ;;
#   esac
# done

# echo "Affected features:" >&2
# printf '%s\n' "${affected_features[@]}" >&2

# features_json_out=$(
#   printf '%s\n' "${affected_features[@]}" |
#     jq -R -s -c 'split("\n") | map(select(length>0))'
# )

echo "features=$features_json" >> "$GITHUB_OUTPUT"
