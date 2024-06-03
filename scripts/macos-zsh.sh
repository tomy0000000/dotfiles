#!/bin/bash

# Change default shell to zsh
echo "📟 Changing default shell to zsh"
chsh -s "/bin/zsh"

# Install zsh dotfiles
stow --dotfiles --target="${HOME}" zsh
