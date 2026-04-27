#!/bin/bash
set -euo pipefail

# This is only available in Ubuntu 25.10+
# Install starship CLI via apt
# sudo apt-get update
# sudo apt-get install -y starship

# Install using official script
# https://starship.rs/guide/#%F0%9F%9A%80-installation
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
