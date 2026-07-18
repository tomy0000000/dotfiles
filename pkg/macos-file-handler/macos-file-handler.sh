#!/bin/bash
set -euo pipefail

# Check this for a list of UTI / extension / MIME mappings
# https://gist.github.com/RhetTbull/7221ef3cfd9d746f34b2550d4419a8c2

# Use this command to check current settings
# defaults export com.apple.LaunchServices/com.apple.launchservices.secure - | plutil -convert json -o - - | jq

# Only handlers for apps without their own pkg/ live here.
# When an app gets a package, move its duti lines into that package's script.

# URL Schemes
duti -s com.readdle.SparkDesktop mailto
duti -s com.apple.iCal webcal
duti -s com.apple.ScreenSharing vnc
duti -s com.apple.FaceTime tel
# Note: Transmit doesn't mount smb/nfs/afp the way Finder does, set per request anyway
duti -s com.panic.Transmit ftp
duti -s com.panic.Transmit webdav
duti -s com.panic.Transmit webdavs
duti -s com.panic.Transmit sftp
duti -s com.panic.Transmit smb
duti -s com.panic.Transmit nfs
duti -s com.panic.Transmit afp

# Remote Desktop (rdp): Microsoft Remote Desktop
# duti -s com.microsoft.rdc.macos rdp

# Default browser (http/https) can't be set via duti
# CI has no browser installed, and setting it triggers a GUI confirmation prompt
if [ -n "${CI:-}" ]; then
    log_info "Skipping default browser"
else
    exist defaultbrowser || brew install defaultbrowser
    defaultbrowser browser
fi

# MIME Types
# duti -s com.brave.Browser text/html viewer
duti -s com.colliderli.iina video/mp4 all
duti -s com.colliderli.iina video/mpeg all
duti -s com.colliderli.iina video/quicktime all
