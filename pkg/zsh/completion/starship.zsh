#!/bin/zsh

zinit ice \
    as"completion" \
    id-as"starship-completion" \
    has"starship" \
    atclone"starship completions zsh > _starship" \
    atpull"%atclone" \
    run-atpull \
    nocompile
zinit light zdharma-continuum/null
