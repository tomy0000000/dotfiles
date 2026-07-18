#!/bin/bash
set -euo pipefail

# Toggle Finder desktop icons visibility
current="$(defaults read com.apple.finder CreateDesktop 2>/dev/null || echo true)"
if [[ "${current}" == "0" || "${current}" == "false" ]]; then
    defaults write com.apple.finder CreateDesktop -bool true
else
    defaults write com.apple.finder CreateDesktop -bool false
fi
killall Finder
