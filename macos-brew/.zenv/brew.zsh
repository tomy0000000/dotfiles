#!/bin/zsh

# Core environment variables
eval "$(/usr/local/bin/brew shellenv)"

# Completions
export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}" # Brew formulae
export FPATH="$(brew --prefix)/share/zsh-completions:${FPATH}"    # zsh-completions

# In favor of homebrew-autoupdate
export HOMEBREW_NO_AUTO_UPDATE="1"
