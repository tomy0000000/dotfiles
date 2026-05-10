#!/bin/bash
set -euo pipefail

# Install Hammerspoon and blueutil
brew bundle --file pkg/macos-hammerspoon/hammerspoon.Brewfile

# Stow Hammerspoon configuration
stow --dir 'pkg/macos-hammerspoon' --target "${HOME}" 'stow'
