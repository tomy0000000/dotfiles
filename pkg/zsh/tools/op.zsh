#!/bin/zsh

zinit ice \
    id-as"op-plugin" \
    has"op" \
    if'[[ -f ${HOME}/.config/op/plugins.sh ]]' \
    atclone"cp ${HOME}/.config/op/plugins.sh op-plugin.sh" \
    atpull"%atclone" \
    run-atpull \
    src="op-plugin.sh" \
    nocompile
zinit light zdharma-continuum/null
