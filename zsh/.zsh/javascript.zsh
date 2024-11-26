#!/bin/zsh

# nodenv hook
if command -v nodenv 1>/dev/null 2>&1; then
    eval "$(nodenv init - zsh)"
fi
