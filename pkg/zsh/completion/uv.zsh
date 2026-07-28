#!/bin/zsh

zinit ice \
    as"completion" \
    id-as"uv-completion" \
    has"uv" \
    atclone"uv generate-shell-completion zsh > _uv" \
    atpull"%atclone" \
    run-atpull \
    nocompile
zinit light zdharma-continuum/null
