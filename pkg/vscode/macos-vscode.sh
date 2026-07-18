#!/bin/bash
set -euo pipefail

# Install Visual Studio Code app if not installed yet
exist code || brew install --cask visual-studio-code

# Create preferred directories
PREFERENCES_DIR="${HOME}/Library/Application Support/Code/User"
mkdir -p "${PREFERENCES_DIR}"

# Stow preferences
stow --no-folding --dir 'pkg/vscode' --target "${PREFERENCES_DIR}" 'stow'

# Default file handlers (duti)
duti -s com.microsoft.VSCode application/json all
duti -s com.microsoft.VSCode application/toml all
duti -s com.microsoft.VSCode application/x-yaml all
duti -s com.microsoft.VSCode command editor
duti -s com.microsoft.VSCode sh editor
duti -s com.microsoft.VSCode text/css all
duti -s com.microsoft.VSCode text/html editor
duti -s com.microsoft.VSCode text/php all
duti -s com.microsoft.VSCode zsh editor
