#!/bin/bash
set -euo pipefail

# Install Dracula theme for Tower
FILE_PATH="${HOME}/Library/Application Support/com.fournova.Tower3/Themes/Dracula.towertheme"
curl -fsSL 'https://raw.githubusercontent.com/dracula/tower/master/Dracula.towertheme' >"${FILE_PATH}"

# Apply settings
defaults import com.fournova.Tower3 macos-tower/com.fournova.Tower3.plist
