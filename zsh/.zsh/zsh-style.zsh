#!/bin/zsh

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
