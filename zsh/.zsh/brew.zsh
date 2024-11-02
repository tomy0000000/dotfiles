#!/bin/zsh

# Reset Homebrew environment variables again
# This was already done in .zenv/brew.zsh
# but it's necessary to run it again here to ensure brew paths are at the beginning
eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

# homebrew-command-not-found hook
antigen bundle command-not-found
