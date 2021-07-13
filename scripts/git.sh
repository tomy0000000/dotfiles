#!/bin/bash
set -e
echo "Setting up git"

ln -s "$(realpath git/.gitalias)" "${HOME}/.gitalias"
ln -s "$(realpath git/.gitconfig)" "${HOME}/.gitconfig"
ln -s "$(realpath git/.gitignore_global)" "${HOME}/.gitignore_global"
