#!/bin/bash
set -euo pipefail

# Install fonts
brew bundle --file pkg/macos-font/macos-font.Brewfile

# Copy font collections
cp -r pkg/macos-font/collection/ "${HOME}/Library/FontCollections"
