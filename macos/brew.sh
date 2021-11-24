#!/bin/bash
set -e

brew_dir="macos/brew"

# Homebrew core
echo "🍺 Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Homebrew aliases
brew tap 'homebrew/aliases'
ln -s "$(realpath "${brew_dir}/.brew-aliases")" "${HOME}/.brew-aliases"
