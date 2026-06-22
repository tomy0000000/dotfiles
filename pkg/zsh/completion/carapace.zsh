#!/bin/zsh

zinit ice \
    as"completion" \
    id-as"carapace-completion" \
    atclone'carapace --list | jq -r '"'keys[]'"' | while read -r cmd; do carapace "${cmd}" zsh > "_${cmd}"; done' \
    atpull"%atclone" \
    run-atpull \
    nocompile
zinit light zdharma-continuum/null
