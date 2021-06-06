#!/usr/bin/env bash
set -e

if [ "$(uname)" = "Linux" ]; then
    distro=$(. /etc/os-release; echo "${NAME}")
    case $distro in
        "Ubuntu")
            . "ubuntu.sh"
            ;;
        *)
            echo "Unsupported distro"
            exit 1
            ;;
    esac
elif [ "$(uname)" = "Darwin" ]; then
    . "macos.sh"
fi

git clone "https://github.com/tomy0000000/dotfiles.git" "${HOME}/.dotfiles"
cd "${HOME}/.dotfiles" | exit 1
