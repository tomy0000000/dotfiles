#!/bin/bash
set -euo pipefail

# Install CLIs
sudo apt-get update
xargs sudo apt-get install -y < pkg/cli-pipe/cli-pipe.Aptfile
