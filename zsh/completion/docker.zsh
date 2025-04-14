#!/bin/zsh

zinit ice \
    as"completion" \
    id-as"docker-completion" \
    has"docker" \
    atclone"docker completion zsh > _docker" \
    atpull"%atclone" \
    run-atpull \
    nocompile
zinit light zdharma-continuum/null
