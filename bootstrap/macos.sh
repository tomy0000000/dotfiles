#!/usr/bin/env bash
set -e

# Install Xcode command line tools
if [ ! -d "$(xcode-select -p)" ]
then
    sudo xcode-select --install
fi
