#!/bin/zsh

# pnpm
if command -v pnpm &>/dev/null; then
    export PNPM_HOME="${HOME}/Library/pnpm"
    export PATH="${PATH}:${PNPM_HOME}"
fi
