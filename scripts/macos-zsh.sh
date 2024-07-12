#!/bin/bash

# Change default shell to zsh

# Test if zsh is already default shell
if [ "$SHELL" = "/bin/zsh" ]; then
    echo "📟 Zsh is already the default shell"
    exit 0
else
    echo "📟 Changing default shell to zsh"
    chsh -s "/bin/zsh"
fi

# Install zsh dotfiles
git clean -dfX zsh/
stow --no-folding --target "${HOME}" zsh
