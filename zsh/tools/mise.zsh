#!/bin/zsh

zinit from"gh-r" \
    as"program" \
    mv"mise* -> mise" \
    atclone'./mise activate zsh > zhook.zsh' \
    atpull'%atclone' \
    pick"mise" \
    src="zhook.zsh" for \
    jdx/mise
