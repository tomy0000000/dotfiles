#!/bin/zsh

# Completion
if command -v op 1>/dev/null 2>&1; then
    eval "$(op completion zsh)"
fi
