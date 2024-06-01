#!/bin/bash
set -e

setting="${HOME}/.jupyter/lab/user-settings"
stow_dir="unix"
stow_package="jupyter"
jupyter_dir="${stow_dir}/${stow_package}"

mkdir -p "${HOME}/.jupyter/lab"

if [ -d "${setting}" ]; then
	echo "${setting} already exists, backed up."
	mv "${setting}" "${setting}.backup"
fi

stow --restow --target "${HOME}/.jupyter" --dir "${stow_dir}" "${stow_package}"
