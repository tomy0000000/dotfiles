#!/bin/bash
set -euo pipefail

# Create preferred directories
PREFERENCES_DIR="${HOME}/Library/Application Support/Sublime Text"
mkdir -p "${PREFERENCES_DIR}/Installed Packages"

# Install Package Control
wget https://packagecontrol.io/Package%20Control.sublime-package \
    -O "${PREFERENCES_DIR}/Installed Packages/Package Control.sublime-package"

# Stow preferences
stow --no-folding --dir 'pkg/sublime' --target "${PREFERENCES_DIR}/Packages" 'stow'

# Stow private preferences if present
if [ -d 'private/pkg/sublime' ] && [ -n "$(ls -A 'private/pkg/sublime' 2>/dev/null)" ]; then
    stow --no-folding --dir 'private/pkg/sublime' --target "${PREFERENCES_DIR}/Packages" 'stow'
else
    echo "⚠️ Private submodule is missing. Partial preferences have been installed."
    echo "⚠️ Hint: Run 'git submodule update --init --recursive' and try again."
fi
