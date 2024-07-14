#!/bin/zsh

# pyenv
if command -v pyenv &>/dev/null; then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"
fi

# pipx
if command -v pipx &>/dev/null; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi
