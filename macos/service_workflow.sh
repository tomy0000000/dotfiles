#!/bin/bash
set -e
echo "👨🏻‍🔧️ Installing services"

install_dir="${HOME}/Library/Services"
stow_dir="macos"
stow_package="services"
service_dir="${stow_dir}/${stow_package}"

for service in "${service_dir}"/*; do
	service=$(basename "${service}")
	echo "${install_dir}/${service}"
	if [ -d "${install_dir}/${service}" ]; then
		if ! (diff -r "${service_dir}/${service}" "${install_dir}/${service}"); then
			echo "⚠️ ${service} already exists, backed up."
			mv "${install_dir}/${service}" "${install_dir}/${service}.backup"
		else
			# Same service already exists
			rm -r "${install_dir:?}/${service:?}"
		fi
	fi
done

stow --restow --target "${install_dir}" --dir "${stow_dir}" "${stow_package}"
