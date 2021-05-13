#!/bin/bash
set -e

for config in configs/.[^.]*
do
    config=$(basename "${config}")
    if [ -f "${HOME}"/"${config}" ]
    then
        echo "${config} already exists, backed up."
        mv "${HOME}/${config}" "${HOME}/${config}.backup"
    fi
done

stow --restow --target "${HOME}" "configs"
