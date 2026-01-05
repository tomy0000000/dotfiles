#!/bin/bash
set -euo pipefail

# Install Perlbrew
sudo mkdir -p "${PERLBREW_ROOT}"
sudo chown -R "$(whoami):admin" "${PERLBREW_ROOT}"
bash -c "$(curl -L https://install.perlbrew.pl)"

# Init Perlbrew
perlbrew init
