#!/bin/zsh

zinit ice \
    id-as"mise-activate" \
    has"mise" \
    atclone"mise activate zsh > mise.zsh" \
    atpull"%atclone" \
    run-atpull \
    src"mise.zsh" \
    nocompile
zinit light zdharma-continuum/null
