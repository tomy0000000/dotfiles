#!/bin/zsh

zinit ice \
    as"completion" \
    id-as"carapace-completion" \
    atclone'carapace --list | awk '"'"'{print $1}'"'"' | while read -r cmd; do carapace "${cmd}" zsh > "_${cmd}"; done' \
    atpull"%atclone" \
    run-atpull \
    nocompile
zinit light zdharma-continuum/null
