#!/bin/bash
set -euo pipefail

# Homebrew core
echo "🍺 Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Homebrew bundle
brew tap homebrew/bundle

# Homebrew extensions
brew bundle --no-lock --file 'brewfiles/core.Brewfile'

# GNU stow
brew install stow

# Homebrew configurations
stow --no-folding --target "${HOME}" macos-brew
