#!/bin/zsh

zinit ice \
    as"completion" \
    id-as"kubectl-completion" \
    has"kubectl" \
    atclone"kubectl completion zsh > _kubectl" \
    atpull"%atclone" \
    run-atpull \
    nocompile
zinit light zdharma-continuum/null
