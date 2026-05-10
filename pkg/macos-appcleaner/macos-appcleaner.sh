#!/bin/bash
set -euo pipefail

# Install AppCleaner app
brew install --cask appcleaner

# Install config
defaults import net.freemacsoft.AppCleaner pkg/macos-appcleaner/net.freemacsoft.AppCleaner.plist
