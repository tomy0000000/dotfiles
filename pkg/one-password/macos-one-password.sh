#!/bin/bash
set -euo pipefail

# Install 1Password app, extensions, and CLI
brew bundle --file pkg/one-password/one-password.Brewfile
