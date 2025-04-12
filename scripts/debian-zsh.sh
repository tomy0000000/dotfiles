#!/bin/bash
set -euo pipefail

# Install Zsh
echo "Installing Zsh..."
sudo apt-get update
sudo apt-get install -y zsh

# Install Zinit
echo "Installing Zinit..."
bash -c "NO_EDIT=true NO_TUTORIAL=true ZINIT_HOME=${HOME}/.local/share ZINIT_REPO_DIR_NAME=zinit $(curl -fsSL https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Install Starship
echo "Installing Starship..."
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Change default shell to zsh
echo "Changing default shell to zsh..."
sudo chsh -s "$(which zsh)" "$(whoami)"

# Install zsh dotfiles
echo "Installing zsh dotfiles..."
mkdir -p "${HOME}/.config"
stow --dir=zsh --no-folding --target "${HOME}/.config" .config
ln -s .dotfiles/zsh/.zshenv "${HOME}/.zshenv"
