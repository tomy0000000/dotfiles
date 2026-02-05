#!/bin/bash
set -euo pipefail

# Install Docker
brew bundle --file pkg/docker/macos-docker.Brewfile
