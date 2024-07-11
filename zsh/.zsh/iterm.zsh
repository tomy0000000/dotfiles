#!/bin/zsh

ITERM2_INT="${HOME}/.iterm2_shell_integration.zsh"
if [ -f "${ITERM2_INT}" ]; then
    source "${ITERM2_INT}"
fi
