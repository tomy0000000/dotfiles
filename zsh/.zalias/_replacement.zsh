#!/bin/zsh

# Use trash instead of rm on local
if command -v "trash" &>/dev/null; then
    alias grm="$(which rm)" # original rm
    alias rm="trash"
fi

# Use colorized cat
if command -v "ccat" &>/dev/null; then
    alias gcat="$(which cat)" # original cat
    alias cat="ccat"
fi

# Use colorized less
if command -v "cless" &>/dev/null; then
    alias gless="$(which less)" # original less
    alias less="cless"
fi
