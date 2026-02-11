#!/usr/bin/env bash
set -euo pipefail

# Install SSH Server
sudo apt update
sudo apt-get install -y openssh-server

# Disable password login
sudo sed -i "s/PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
sudo sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config

# Setup authorized key
if [ ! -f "${HOME}/.ssh/authorized_keys" ]; then
    ssh-import-id gh:tomy0000000
fi

# Restart Service
sudo service ssh restart
