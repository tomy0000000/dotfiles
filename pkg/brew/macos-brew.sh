#!/bin/bash
set -euo pipefail

BREW_BIN="$(bin/brew_bin)"

# Install Homebrew
# Reference: https://brew.sh/
if ! command -v brew &>/dev/null; then
    echo "🍺 Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "🍺 Homebrew is already installed"
fi

# Install core packages
echo "🍺 Installing Homebrew packages"
"${BREW_BIN}/brew" bundle --file pkg/brew/brew.Brewfile

# Install aliases
# Do folding here to sync new aliases back to dotfiles
echo "🍺 Stowing Homebrew aliases"
"${BREW_BIN}/stow" --dir 'pkg/brew' --target "${HOME}" 'stow'

# Start autoupdate service
if "${BREW_BIN}/brew" autoupdate status | grep -q 'stopped'; then
    echo "🍺 Starting Homebrew autoupdate service"
    "${BREW_BIN}/brew" autoupdate start
else
    echo "🍺 Homebrew autoupdate service is already running"
fi
