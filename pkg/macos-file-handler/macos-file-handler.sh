#!/bin/bash
set -euo pipefail

# Check this for a list of UTI / extension / MIME mappings
# https://gist.github.com/RhetTbull/7221ef3cfd9d746f34b2550d4419a8c2

# Use this command to check current settings
# defaults export com.apple.LaunchServices/com.apple.launchservices.secure - | plutil -convert json -o - - | jq

# URL Schemes
duti -s com.googlecode.iterm2 ssh
duti -s com.panic.Transmit ftp

duti -s com.readdle.SparkDesktop mailto
duti -s com.googlecode.iterm2 x-man-page
duti -s com.googlecode.iterm2 telnet
duti -s com.apple.iCal webcal
# Note: Transmit doesn't mount smb/nfs/afp the way Finder does, set per request anyway
duti -s com.panic.Transmit webdav
duti -s com.panic.Transmit webdavs
duti -s com.panic.Transmit sftp
duti -s com.panic.Transmit smb
duti -s com.panic.Transmit nfs
duti -s com.panic.Transmit afp
duti -s com.apple.ScreenSharing vnc
duti -s com.apple.FaceTime tel

# Remote Desktop (rdp): Microsoft Remote Desktop
# duti -s com.microsoft.rdc.macos rdp

# Default browser (http/https) can't be set via duti
exist defaultbrowser || brew install defaultbrowser
defaultbrowser browser

# MIME Types

duti -s com.sublimetext.4 text/plain all
# duti -s com.brave.Browser text/html viewer
# duti -s com.microsoft.VSCode text/html editor
duti -s com.microsoft.VSCode text/css all
duti -s com.microsoft.VSCode application/toml all
duti -s com.microsoft.VSCode application/json all
duti -s com.microsoft.VSCode text/php all
duti -s com.microsoft.VSCode application/x-yaml all
duti -s com.sublimetext.4 text/csv all
duti -s com.colliderli.iina video/mp4 all
duti -s com.colliderli.iina video/mpeg all
duti -s com.colliderli.iina video/quicktime all

# Extensions
# Prefer MIME over extension where possible

duti -s com.microsoft.VSCode command editor
duti -s com.googlecode.iterm2 command shell
duti -s com.microsoft.VSCode sh editor
duti -s com.googlecode.iterm2 sh shell
duti -s com.microsoft.VSCode zsh editor
duti -s com.googlecode.iterm2 zsh shell
