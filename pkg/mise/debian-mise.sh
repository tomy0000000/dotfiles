#!/bin/bash
set -euo pipefail

KEYRING='/etc/apt/keyrings/mise-archive-keyring.gpg'
SOURCES_LIST='/etc/apt/sources.list.d/mise.list'

# Set up mise APT repo (idempotent)
# https://mise.jdx.dev/installing-mise.html#apt
sudo apt-get update -y
sudo apt-get install -y gpg sudo wget curl
sudo install -dm 755 /etc/apt/keyrings
if [ ! -f "${KEYRING}" ]; then
    wget -qO - https://mise.jdx.dev/gpg-key.pub \
        | sudo gpg --dearmor -o "${KEYRING}"
fi
ARCH="$(dpkg --print-architecture)"
echo "deb [signed-by=${KEYRING} arch=${ARCH}] https://mise.jdx.dev/deb stable main" \
    | sudo tee "${SOURCES_LIST}" >/dev/null

# Install mise CLI via APT
sudo apt-get update
xargs sudo apt-get install -y mise

# Run global setup script
bash pkg/mise/mise.sh
