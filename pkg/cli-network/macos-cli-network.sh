#!/bin/bash
set -euo pipefail

# Install CLIs
brew bundle --file pkg/cli-network/cli-network.Brewfile
