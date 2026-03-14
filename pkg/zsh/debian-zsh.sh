#!/bin/bash
set -euo pipefail

# Load .zshenv to get XDG_CONFIG_HOME
set +u
# shellcheck source=pkg/zsh/.zshenv
source 'pkg/zsh/.zshenv'
set -u

trap 'unset ZSH_BIN USER_SHELL' EXIT

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
mkdir -p "${XDG_CONFIG_HOME}" # Make sure XDG_CONFIG_HOME exists
if [ -f "${HOME}/.zshenv" ]; then
    mv "${HOME}/.zshenv" "${HOME}/.zshenv.bk"
    echo "Warning: existing .zshenv found, backed up to .zshenv.bk"
fi
ln -sf .dotfiles/zsh/.zshenv "${HOME}/.zshenv"
