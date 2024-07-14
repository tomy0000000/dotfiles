#!/bin/zsh

if command -v brew &>/dev/null; then
    # Core environment variables
    eval "$(/usr/local/bin/brew shellenv)"

    # Completions
    export FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}" # Brew formulae
    export FPATH="${HOMEBREW_PREFIX}/share/zsh-completions:${FPATH}"    # zsh-completions

    # In favor of homebrew-autoupdate
    export HOMEBREW_NO_AUTO_UPDATETE="1"
fi
