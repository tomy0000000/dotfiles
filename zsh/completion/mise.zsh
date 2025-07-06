#!/bin/zsh

zinit ice \
    as"completion" \
    id-as"mise-completion" \
    has"mise" \
    atclone"mise use -g usage && mise completion zsh > _mise" \
    atpull"%atclone" \
    run-atpull \
    nocompile
zinit light zdharma-continuum/null
