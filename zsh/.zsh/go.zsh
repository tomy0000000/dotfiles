#!/bin/zsh

# goenv
if command -v goenv 1>/dev/null 2>&1; then
    eval "$(goenv init -)"
    export GOPATH="${HOME}/.go/$(goenv global)"
    export PATH="${GOROOT}/bin:${PATH}"
    export PATH="${PATH}:${GOPATH}/bin"
fi
