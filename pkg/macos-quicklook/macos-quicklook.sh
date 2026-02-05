#!/bin/bash
set -euo pipefail

# Install QuickLook plugins
brew bundle --file macos-quicklook/quicklook.Brewfile
