#!/bin/zsh

zinit from"gh-r" \
    as"program" \
    mv"zoxide* -> zoxide" \
    atclone'./zoxide init zsh > zhook.zsh' \
    atpull'%atclone' \
    pick"zoxide" \
    src="zhook.zsh" for \
    ajeetdsouza/zoxide
