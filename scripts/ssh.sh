#!/bin/bash
set -e

# Install SSH Server
sudo apt update
sudo apt-get install -y openssh-server

# Setup authorized key
ssh-import-id gh:tomy0000000

# Disable password login
sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config

# Restart Service
sudo service ssh restart
