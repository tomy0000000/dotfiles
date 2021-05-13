#!/usr/bin/env bash
set -e

if [ ! -d "$(xcode-select -p)" ]
then
    sudo xcode-select --install
fi
