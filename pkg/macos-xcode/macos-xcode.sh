#!/bin/bash
set -euo pipefail

# Install Xcode
brew bundle --file pkg/xcode/macos-xcode.Brewfile
