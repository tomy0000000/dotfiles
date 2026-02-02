#!/bin/bash
set -euo pipefail

# Create preferred directories
PREFERENCES_DIR="${HOME}/Library/Application Support/Code/User"
mkdir -p "${PREFERENCES_DIR}"

# Stow preferences
stow --no-folding --dir 'pkg/vscode' --target "${PREFERENCES_DIR}" 'stow'
