#!/bin/zsh

# pip completions
zinit snippet OMZP::pip

# pyenv hook
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
