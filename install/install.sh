#!/usr/bin/env bash
set -e

if [ "$(uname)" = "Linux" ]; then
    distro=$(
        . /etc/os-release
        echo "${NAME}"
    )
    case $distro in
    'Ubuntu')
        # Install crucial commands
        apt update
        apt install -y sudo make git
        ;;
    *)
        echo 'Unsupported distro'
        exit 1
        ;;
    esac
elif [ "$(uname)" = 'Darwin' ]; then
    # Install Xcode command line tools
    if [ ! -d "$(xcode-select -p)" ]; then
        sudo xcode-select --install
    fi
fi

git clone 'https://github.com/tomy0000000/dotfiles.git' "${HOME}/.dotfiles"
cd "${HOME}/.dotfiles" || exit 1
