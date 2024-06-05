#!/bin/zsh

# Antigen
source "/usr/local/share/antigen/antigen.zsh"
antigen use oh-my-zsh # this implicitly runs compinit

# Theme
antigen theme "dracula/zsh"

# Plugins
# https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
antigen bundle autojump
antigen bundle colored-man-pages
antigen bundle colorize # ccat, cless
antigen bundle direnv   # hook
antigen bundle macos    # commands
antigen bundle starship # hook
antigen bundle sudo
antigen bundle thefuck # alias
antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle atuinsh/atuin@main

# Autoload all functions
for func in "${HOME}"/.zfunc/*; do
    autoload -U ${func:t}
done

# Alias
for alias in "${HOME}"/.zalias/*; do
    source "${alias}"
done

# Third-party integrations
for script in "${HOME}"/.zsh/*; do
    source "${script}"
done

# Zsh style

## Setup completer
zstyle ':completion:*' completer _extensions _expand_alias _complete

## SSH Host completion
zstyle ':completion:*:ssh:*' hosts

## Show long file list sorted by latest accessed first
zstyle ':completion:*' file-list all
zstyle ':completion:*' file-sort access

# Show message in group
zstyle ':completion:*' group-name ''                                                 # Group name
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands # Group order
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'  # Show corrections
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'               # Show descriptions
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'                      # Show messages
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'            # Show warnings

## Highlight current selection
zstyle ':completion:*' menu select

# Apply antigen bundles
antigen apply
