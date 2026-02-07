#!/bin/bash
set -euo pipefail

# Install Xcode
brew bundle --file pkg/macos-xcode/xcode.Brewfile
