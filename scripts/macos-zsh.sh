#!/bin/bash

# Change default shell to zsh
echo "📟 Changing default shell to zsh"
chsh -s "/bin/zsh"

# Install zsh dotfiles
stow --no-folding --target "${HOME}" zsh
