#!/bin/bash
set -e

config_dir="configs"
for config in "${config_dir}"/.[^.]*; do
	config=$(basename "${config}")
	if [ -f "${HOME}"/"${config}" ] && ! (cmp --silent "${config_dir}/${config}" "${HOME}/${config}"); then
		echo "⚠️ ${config} already exists, backed up."
		mv "${HOME}/${config}" "${HOME}/${config}.backup"
	fi
done

stow --restow --target "${HOME}" "${config_dir}"
