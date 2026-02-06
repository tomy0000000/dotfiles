#!/bin/bash
set -euo pipefail

# Install QuickLook plugins
brew bundle --file pkg/macos-quicklook/quicklook.Brewfile
