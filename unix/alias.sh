#!/bin/bash
set -e
echo "⚡️ Installing alias"

alias_dir="unix/alias"

# Check existed alias
if [ -d "${HOME}/.alias" ] || [ -L "${HOME}/.alias" ]; then
	echo ".alias already exists, backed up."
	mv "${HOME}/.alias" "${HOME}/.alias.backup"
fi

# Stow the alias
ln -s "$(realpath "${alias_dir}")" "${HOME}/.alias"

# Add source file line in rc file
shellrc="${HOME}/.$(echo "${SHELL}" | cut -d'/' -f'3')rc"
cat >>"${shellrc}" <<"EOF"
for alias in ${HOME}/.alias/*; do
  source "${alias}"
done
EOF
