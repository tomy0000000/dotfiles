#!/bin/bash
set -euo pipefail

# Install Alfred
brew install --cask alfred

# Modify Shortcuts
defaults export com.apple.symbolichotkeys - |
    # Show Spotlight search: Off
    plutil -replace AppleSymbolicHotKeys.64.enabled -bool NO -o - - |
    # Show Finder search window: Off
    plutil -replace AppleSymbolicHotKeys.65.enabled -bool NO -o - - |
    defaults import com.apple.symbolichotkeys -

# Reload Shortcuts
# Reference:
# https://zameermanji.com/blog/2021/6/8/applying-com-apple-symbolichotkeys-changes-instantaneously/
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
