#!/bin/bash
set -euo pipefail

echo "📦️ Installing Dropbox"

DEBIAN_FRONTEND=noninteractive sudo apt-get install -y libc6 libglapi-mesa libglib2.0-0 libxdamage1 libxfixes3 libxcb-glx0 libxcb-dri2-0 libxcb-dri3-0 libxcb-present0 libxcb-sync1 libxshmfence1 libxxf86vm1
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
sudo wget -O "/usr/local/bin/dropbox" "https://www.dropbox.com/download?dl=packages/dropbox.py"
sudo chmod a+x "/usr/local/bin/dropbox"

echo "Run '~/.dropbox-dist/dropboxd' to start Dropbox Daemon"
