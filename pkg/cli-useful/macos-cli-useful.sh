#!/bin/bash
set -euo pipefail

# Install CLIs
brew bundle --file pkg/cli-useful/cli-useful.Brewfile
