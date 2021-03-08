#!/bin/bash
echo "⚡️ Installing alias"

# Check existed alias
if [ -d "${HOME}/.alias" ]; then
    # for alias in alias/*; do
    #     if [ -f "${HOME}/.alias/${alias}" ]; then
    #         echo "${alias} already exists, backed up."
    #         mv "${HOME}/${alias}" "${HOME}/${alias}.backup"
    #     fi
    # done
    echo ".alias already exists, backed up."
    mv "${HOME}/.alias" "${HOME}/.alias.backup"
else
    # mkdir -p "${HOME}/.alias"
    true
fi

# Stow the alias
# stow --target "${HOME}/.alias" "alias"
ln -s "$(realpath alias)" "${HOME}/.alias"

# Add source file line in rc file
shellrc="${HOME}/.$(echo "${SHELL}" | cut -d'/' -f'3')rc"
cat >> "${shellrc}" << "EOF"
for alias in ${HOME}/.alias/*; do
  source "${alias}"
done
EOF
