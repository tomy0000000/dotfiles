#!/bin/bash
set -e

setting="${HOME}/.jupyter/lab/user-settings"
jupyter_dir="unix/jupyter"
mkdir -p "${HOME}/.jupyter/lab"

if [ -d "${setting}" ]; then
	echo "${setting} already exists, backed up."
	mv "${setting}" "${setting}.backup"
fi

stow --restow --target "${HOME}/.jupyter" "${jupyter_dir}"
