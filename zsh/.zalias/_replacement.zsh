#!/bin/zsh

# Use trash instead of rm on local
if command -v "trash" &>/dev/null; then
    alias orm="$(which rm)" # original rm
    alias rm="trash"
fi

# Use colorized cat
if command -v "ccat" &>/dev/null; then
    alias ocat="$(which cat)" # original cat
    alias cat="ccat"
fi

# Use colorized less
if command -v "cless" &>/dev/null; then
    alias oless="$(which less)" # original less
    alias less="cless"
fi

# Use GNU sed
if command -v "gsed" &>/dev/null; then
    alias msed="$(which sed)" # original macOS sed
    alias sed="gsed"
fi
