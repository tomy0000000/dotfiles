#!/bin/bash
set -euo pipefail

# Import preferences from dotfiles
# shellcheck disable=SC2088
defaults write com.googlecode.iterm2 PrefsCustomFolder -string '~/.dotfiles/pkg/macos-iterm'
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
