#!/bin/bash
set -euo pipefail

brew install --cask appcleaner
defaults import net.freemacsoft.AppCleaner pkg/macos-appcleaner/net.freemacsoft.AppCleaner.plist
