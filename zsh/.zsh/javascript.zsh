#!/bin/zsh

# pnpm
if command -v pnpm &>/dev/null; then
    export PNPM_HOME="${HOME}/Library/pnpm"
    export PATH="${PNPM_HOME}:${PATH}"
fi
