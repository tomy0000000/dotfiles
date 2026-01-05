#!/bin/bash
set -euo pipefail

FILE_PATH="${HOME}/Library/Application Support/com.fournova.Tower3/Themes/Dracula.towertheme"

# Create parent directory
mkdir -p "$(dirname "$FILE_PATH")"

# Install Dracula theme for Tower
curl -fsSL 'https://raw.githubusercontent.com/dracula/tower/master/Dracula.towertheme' >"${FILE_PATH}"

# Apply settings
defaults import com.fournova.Tower3 pkg/macos-tower/com.fournova.Tower3.plist
