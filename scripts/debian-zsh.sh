#!/bin/bash
set -euo pipefail

SCRIPT_DIR=$(dirname "$0")
ABSOLUTE_SCRIPT_DIR=$(realpath "${SCRIPT_DIR}")

# Install Zsh
sudo apt-get update
sudo apt-get install -y zsh

# Install Antigen
wget 'https://git.io/antigen' --output-document "${ABSOLUTE_SCRIPT_DIR}/antigen"
if [ -f "${ABSOLUTE_SCRIPT_DIR}/antigen" ]; then
    sudo mkdir -p '/usr/local/share/antigen'
    sudo mv "${ABSOLUTE_SCRIPT_DIR}/antigen" /usr/local/share/antigen/antigen.zsh
    echo "Antigen installed successfully"
else
    echo "Antigen installation failed"
    exit 1
fi

# Install Starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Change default shell to zsh
sudo chsh -s "$(which zsh)" "$(whoami)"

# Install zsh dotfiles
stow --no-folding --target "${HOME}" zsh
