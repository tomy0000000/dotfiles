#!/bin/bash
set -euo pipefail

# Install iterm2
brew install --cask iterm2

# Import preferences from dotfiles
# shellcheck disable=SC2088
defaults write com.googlecode.iterm2 PrefsCustomFolder -string '~/.dotfiles/pkg/macos-iterm'
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# Default file/URL handlers (duti)
duti -s com.googlecode.iterm2 command shell
duti -s com.googlecode.iterm2 sh shell
duti -s com.googlecode.iterm2 ssh
duti -s com.googlecode.iterm2 telnet
duti -s com.googlecode.iterm2 x-man-page
duti -s com.googlecode.iterm2 zsh shell
