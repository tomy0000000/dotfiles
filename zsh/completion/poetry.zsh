#!/bin/zsh

zinit ice \
    as"completion" \
    id-as"poetry-completion" \
    has"poetry" \
    atclone"poetry completions zsh > _poetry" \
    atpull"%atclone" \
    run-atpull \
    nocompile
zinit light zdharma-continuum/null
