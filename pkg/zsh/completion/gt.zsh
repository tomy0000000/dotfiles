#!/bin/zsh

zinit ice \
    as"completion" \
    id-as"gt-completion" \
    has"gt" \
    atclone"gt completion > _gt" \
    atpull"%atclone" \
    run-atpull \
    nocompile
zinit light zdharma-continuum/null
