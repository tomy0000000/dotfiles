#!/bin/bash
set -euo pipefail

# Change default shell to zsh
if [ -z "${CI:-}" ]; then
    if [ "${SHELL}" != "/bin/zsh" ]; then
        echo "📟 Changing default shell to zsh"
        chsh -s "/bin/zsh"
    else
        echo "📟 Zsh is already the default shell"
    fi
else
    echo "📟 Skipping changing default shell to zsh"
fi

# Install zsh dotfiles
git clean -dfX zsh/
stow --no-folding --target "${HOME}" zsh
