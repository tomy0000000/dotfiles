#!/bin/bash
# .github/scripts/merge-features.sh
# Merge passed in features with a list of fixed features

set -euo pipefail

FIXED_FEATURES=(
    # ansible
    # clean
    # cli-network
    # core
    git
    # javascript
    # macos-brew
    # macos-c-cpp
    # macos-clean
    # macos-cli-network
    # macos-cli-useful
    # macos-core
    # macos-docker
    # macos-duti
    # macos-file-handler
    # macos-finder
    # macos-git
    # macos-icon
    # macos-javascript
    # macos-markedit
    # macos-micro
    # macos-nano
    # macos-popclip
    # macos-quicklook
    # macos-screensaver
    # macos-shellcheck
    # macos-stow
    # macos-sublime
    # macos-terminal
    # macos-touch-id-sudo
    # macos-vscode
    # macos-zsh
    # micro
    # nano
    # python
    # stow
    # zsh
)

if [ $# -lt 1 ]; then
  echo "Usage: $0 <features_json>" >&2
  exit 1
fi

features_json="$1"

if [ -z "$features_json" ] || [ "$features_json" = "null" ]; then
  features_json="[]"
fi

if ! echo "$features_json" | jq -e '.' >/dev/null 2>&1; then
  echo "Invalid JSON for features." >&2
  exit 1
fi

fixed_json=$(
  printf '%s\n' "${FIXED_FEATURES[@]}" |
    jq -R -s -c 'split("\n") | map(select(length>0))'
)

merged_json=$(
  echo "$features_json" |
    jq -c --argjson fixed "$fixed_json" '. + $fixed | sort | unique'
)

echo "Merged features:" >&2
echo "$merged_json" | jq -r '.[]' >&2

echo "features=$merged_json" >> "$GITHUB_OUTPUT"
