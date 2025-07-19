#!/bin/zsh

zinit ice from"gh-r" \
    as"program" \
    mv"carapace* -> carapace" \
    pick"carapace" \
    atpull'carapace --selfupdate'
zinit light carapace-sh/carapace-bin
