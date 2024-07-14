#!/bin/bash
set -euo pipefail

# Change default shell to zsh
if [ "$SHELL" = "/bin/zsh" ]; then
    echo "📟 Zsh is already the default shell"
else
    echo "📟 Changing default shell to zsh"
    chsh -s "/bin/zsh"
fi

# Install zsh dotfiles
git clean -dfX zsh/
stow --no-folding --target "${HOME}" zsh
