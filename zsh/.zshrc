#!/bin/zsh

# Init bash completions
autoload -U +X compinit
compinit

# Init bash completions
autoload -U +X bashcompinit
bashcompinit

# Sheldon
eval "$(sheldon source)"

# Third-party integrations
for script in "${ZDOTDIR}"/.zsh/*; do
    source "${script}"
done

# Autoload all functions
for func in "${ZDOTDIR}"/.zfunc/*; do
    autoload -U ${func:t}
done

# Alias
for alias in "${ZDOTDIR}"/.zalias/*; do
    source "${alias}"
done
