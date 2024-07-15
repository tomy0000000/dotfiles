#!/bin/bash
set -euo pipefail

# Change default shell to zsh
if [ -n "${GITHUB_ACTIONS:-}" ]; then
    if [ "${SHELL}" != "/bin/zsh" ]; then
        echo "📟 Changing default shell to zsh"
        chsh -s "/bin/zsh"
    else
        echo "📟 Zsh is already the default shell"
    fi
fi

# Install zsh dotfiles
git clean -dfX zsh/
stow --no-folding --target "${HOME}" zsh
