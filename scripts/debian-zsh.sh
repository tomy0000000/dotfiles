#!/bin/bash
set -euo pipefail

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
ln -s .dotfiles/zsh/.zshenv "${HOME}/.zshenv"
