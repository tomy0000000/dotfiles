#!/bin/zsh

# Use trash instead of rm on local
alias grm="$(which rm)" # original rm
alias rm="trash"

# Use colorized cat and less
alias gcat="$(which cat)"   # original cat
alias gless="$(which less)" # original less
alias cat="ccat"
alias less="cless"
