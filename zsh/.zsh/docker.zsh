#!/bin/zsh

# Completion
if command -v docker 1>/dev/null 2>&1; then
    eval "$(docker completion zsh)"
fi
