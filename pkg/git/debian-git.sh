#!/bin/bash
set -euo pipefail

# Install git and miscellaneous tools
sudo apt-get update
xargs sudo apt-get install -y < pkg/git/git.Aptfile

# Run global setup script
bash pkg/git/git.sh
