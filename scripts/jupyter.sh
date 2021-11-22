#!/bin/bash
set -e

mkdir -p "${HOME}/.jupyter/lab"
setting="${HOME}/.jupyter/lab/user-settings"

if [ -d "${setting}" ]; then
	echo "${setting} already exists, backed up."
	mv "${setting}" "${setting}.backup"
fi

stow --restow --target "${HOME}/.jupyter" "jupyter"
