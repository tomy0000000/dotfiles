#!/bin/zsh

zinit ice from"gh-r" \
    as"command" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" \
    src"init.zsh"

zinit light starship/starship
