#!/bin/bash
set -euo pipefail

# Load .zshenv to get XDG_CONFIG_HOME
set +u
source 'zsh/.zshenv'
set -u

ZSH_BIN="${HOMEBREW_PREFIX}/bin/zsh" # Homebrew zsh
USER_SHELL=$(dscl . -read "${HOME}" UserShell | awk '{print $2}')
MISE_DIR="${XDG_CONFIG_HOME}/mise"
trap 'unset ZSH_BIN USER_SHELL MISE_DIR' EXIT

# Skip if running in CI
if [ -n "${CI:-}" ]; then
    echo "📟 Skipping changing default shell to zsh"
    exit 0
fi

# Make sure Homebrew zsh is in /etc/shells
if ! grep -q "${ZSH_BIN}" /etc/shells; then
    echo "📟 Adding Homebrew zsh to /etc/shells"
    echo "${ZSH_BIN}" | sudo tee -a /etc/shells
fi

# Change default shell to zsh
if [ "${USER_SHELL}" != "${ZSH_BIN}" ]; then
    echo "📟 Changing default shell to zsh"
    chsh -s "${ZSH_BIN}"
fi

# Install zsh dotfiles
echo "Installing zsh dotfiles..."
mkdir -p "${HOME}/.config" # Make sure XDG_CONFIG_HOME exists
ln -sf .dotfiles/zsh/.zshenv "${HOME}/.zshenv"

# Install mise dotfiles
mkdir -p "${MISE_DIR}"
stow --no-folding --target "${MISE_DIR}" 'mise'
