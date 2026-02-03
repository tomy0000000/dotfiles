#!/bin/bash
# .github/scripts/merge-features.sh
# Merge passed in features with a list of fixed features

set -euo pipefail

FIXED_FEATURES=(
    ansible
    clean
    cli-network
    core
    git
    javascript
    macos-appcleaner
    macos-brew
    macos-c-cpp
    macos-clean
    macos-cli-network
    macos-cli-useful
    macos-core
    macos-docker
    macos-duti
    macos-file-handler
    macos-finder
    macos-font
    macos-git
    macos-hammerspoon
    macos-icon
    macos-iterm
    macos-javascript
    macos-markedit
    macos-micro
    macos-nano
    macos-popclip
    macos-quicklook
    macos-screensaver
    macos-service-workflow
    macos-shellcheck
    macos-stow
    macos-sublime
    macos-terminal
    macos-touch-id-sudo
    macos-tower
    macos-vscode
    macos-zsh
    micro
    nano
    python
    stow
    zsh
)