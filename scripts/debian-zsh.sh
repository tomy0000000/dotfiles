#!/bin/bash
set -euo pipefail

# Load .zshenv to get XDG_CONFIG_HOME
set +u
# shellcheck disable=SC1091
source 'zsh/.zshenv'
set -u

MISE_DIR="${XDG_CONFIG_HOME}/mise"
trap 'unset ZSH_BIN USER_SHELL MISE_DIR' EXIT

# Install Zsh
echo "Installing Zsh..."
sudo apt-get update
sudo apt-get install -y file zsh

# Install Zinit
echo "Installing Zinit..."
bash -c "NO_EDIT=true NO_TUTORIAL=true ZINIT_HOME=${HOME}/.local/share ZINIT_REPO_DIR_NAME=zinit $(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Change default shell to zsh
echo "Changing default shell to zsh..."
sudo chsh -s "$(which zsh)" "$(whoami)"

# Install zsh dotfiles
echo "Installing zsh dotfiles..."
mkdir -p "${HOME}/.config" # Make sure XDG_CONFIG_HOME exists
if [ -f "${HOME}/.zshenv" ]; then
    mv "${HOME}/.zshenv" "${HOME}/.zshenv.bk"
    echo "Warning: existing .zshenv found, backed up to .zshenv.bk"
fi
ln -sf .dotfiles/zsh/.zshenv "${HOME}/.zshenv"

# Install mise dotfiles
mkdir -p "${MISE_DIR}"
stow --no-folding --target "${MISE_DIR}" 'mise'
