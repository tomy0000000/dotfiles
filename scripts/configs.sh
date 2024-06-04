#!/bin/bash
set -e

configs=".npmrc"
stow_dir="unix"
stow_package="configs"
config_dir="${stow_dir}/${stow_package}"

for config in ${configs}; do
	old-configs "${HOME}/${config}" "${config_dir}/${config}"
done

stow --restow --target "${HOME}" --dir "${stow_dir}" "${stow_package}"
