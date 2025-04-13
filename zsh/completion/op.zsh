#!/bin/zsh

zinit ice \
    as"completion" \
    id-as"op-completion" \
    has"op" \
    atclone"op completion zsh > _op" \
    atpull"%atclone" \
    run-atpull \
    nocompile
zinit light zdharma-continuum/null
