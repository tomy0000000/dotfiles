#!/bin/bash
set -euo pipefail

# Homebrew core
echo "🍺 Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Setup homebrew for this particular shell
UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ "${UNAME_MACHINE}" == "arm64" ]]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
fi
eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

# Setup temporary Homebrew alias
# shellcheck disable=SC2139
alias brew="${HOMEBREW_PREFIX}/bin/brew"

# Homebrew bundle
brew tap homebrew/bundle

# Homebrew extensions
brew bundle --no-lock --file 'brewfiles/core.Brewfile'

# GNU stow
brew install stow

# Homebrew configurations
stow --no-folding --target "${HOME}" macos-brew
