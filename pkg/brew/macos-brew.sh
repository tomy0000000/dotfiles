#!/bin/bash
set -euo pipefail

# Install Homebrew
# Reference: https://brew.sh/
if ! command -v brew &>/dev/null; then
    echo "🍺 Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Polyfill this shell session so we can use brew immediately
    eval "$(abs_brew shellenv)"
else
    echo "🍺 Homebrew is already installed"
fi

# Install core packages
echo "🍺 Installing Homebrew packages"
brew bundle --file pkg/brew/brew.Brewfile

# Install aliases
# Do folding here to sync new aliases back to dotfiles
echo "🍺 Stowing Homebrew aliases"
stow --dir 'pkg/brew' --target "${HOME}" 'stow'

# Start autoupdate service
if brew autoupdate status | grep -q 'stopped'; then
    echo "🍺 Starting Homebrew autoupdate service"
    brew autoupdate start
else
    echo "🍺 Homebrew autoupdate service is already running"
fi
