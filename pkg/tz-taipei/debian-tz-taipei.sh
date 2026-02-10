#!/usr/bin/env bash
set -euo pipefail

# Configure timezone
sudo ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime

# Install tzdata
sudo apt-get update
sudo apt-get install -y tzdata

# Reconfigure tzdata
sudo dpkg-reconfigure --frontend noninteractive tzdata
