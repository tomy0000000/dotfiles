#!/bin/bash
set -euo pipefail

# Modify Shortcuts
defaults export com.apple.symbolichotkeys - |
    # Save picture of screen as a file: Off
    plutil -replace AppleSymbolicHotKeys.28.enabled -bool NO -o - - |
    # Copy picture of screen to the clipboard: Off
    plutil -replace AppleSymbolicHotKeys.29.enabled -bool NO -o - - |
    # Save picture of selected area as a file: Off
    plutil -replace AppleSymbolicHotKeys.30.enabled -bool NO -o - - |
    # Copy picture of selected area to the clipboard: Off
    plutil -replace AppleSymbolicHotKeys.31.enabled -bool NO -o - - |
    # Screenshot and recording options: Off
    plutil -replace AppleSymbolicHotKeys.184.enabled -bool NO -o - - |
    defaults import com.apple.symbolichotkeys -

# Reload Shortcuts
# Reference:
# https://zameermanji.com/blog/2021/6/8/applying-com-apple-symbolichotkeys-changes-instantaneously/
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# Get domain of CleanShot X
# For standard version: com.getcleanshot.app
# For Setapp version: com.getcleanshot.app-setapp
domain=$(osascript -e 'id of app "CleanShot X"')

###############################################################################
# Wallpaper                                                                   #
###############################################################################

# Window screenshot: Transparent
defaults write "${domain}" transparentWindowBackground -bool true

###############################################################################
# Shortcuts                                                                   #
###############################################################################

# General > All-In-One:
defaults write "${domain}" LAVAtakeAllInOne -data 7B22636172626F6E4D6F64696669657273223A3736382C22636172626F6E4B6579223A31387D

# OCR > Capture Text:
defaults write "${domain}" LAVAtakeOCR -data 7B22636172626F6E4B6579223A32322C22636172626F6E4D6F64696669657273223A3736387D
