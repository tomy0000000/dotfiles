#!/bin/zsh

# pip completions
antigen bundle pip

# pyenv hook
eval "$(pyenv init -)"

# pipx completions
eval "$(register-python-argcomplete --shell zsh pipx)"
