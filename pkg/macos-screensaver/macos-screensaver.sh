#!/bin/bash
set -euo pipefail

# Install screensavers
brew bundle --file pkg/macos-screensaver/screensaver.Brewfile
