#!/bin/bash
set -euo pipefail

# Install Visual Studio Code app if not installed yet
exist code || brew install --cask visual-studio-code

# Create preferred directories
PREFERENCES_DIR="${HOME}/Library/Application Support/Code/User"
mkdir -p "${PREFERENCES_DIR}"

# Stow preferences
stow --no-folding --dir 'pkg/vscode' --target "${PREFERENCES_DIR}" 'stow'
