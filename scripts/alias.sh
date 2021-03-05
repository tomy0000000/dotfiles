#!/bin/bash
echo "⚡️ Installing alias"

# Check existed alias
if [ -d "${HOME}/.alias" ]; then
    for alias in alias/*; do
        if [ -f "${HOME}/.alias/${alias}" ]; then
            echo "${alias} already exists, backed up."
            mv "${HOME}/${alias}" "${HOME}/${alias}.backup"
        fi
    done
else
    mkdir -p "${HOME}/.alias"
fi

# Stow the alias
stow --target "${HOME}/.alias" "alias"

# Add source file
shellrc="${HOME}/.$(echo "${SHELL}" | cut -d'/' -f'3')rc"
cat >> "${shellrc}" << "EOF"
for alias in .alias/*; do
  source "${alias}"
done
EOF
