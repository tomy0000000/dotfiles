#!/bin/bash
set -euo pipefail

# Install apps
brew bundle --file pkg/macos-app-dev/app-dev.Brewfile
