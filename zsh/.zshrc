#!/bin/zsh

# Antigen
source "${HOMEBREW_PREFIX:-/usr/local}/share/antigen/antigen.zsh"
antigen use oh-my-zsh # this implicitly runs compinit

# Init bash completions
autoload -U +X bashcompinit
bashcompinit

# Theme
antigen theme "dracula/zsh"

# Plugins
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
antigen bundle colored-man-pages
antigen bundle colorize # ccat, cless
antigen bundle direnv   # hook
antigen bundle macos    # commands
antigen bundle starship # hook
antigen bundle sudo
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle atuinsh/atuin@main

# Apply antigen bundles
antigen apply

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
