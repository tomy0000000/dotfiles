#!/bin/bash
set -e
echo " Setting up git"

configs=".gitalias .gitattributes .gitconfig .gitignore_global .stCommitMsg"
git_dir="git"

for config in ${configs}
do
    if [ -f "${HOME}/${config}" ]
    then
        if ! (diff -r "${git_dir}/${config}" "${HOME}/${config}")
        then
            echo "⚠️ ${config} already exists, backed up."
            mv "${HOME}/${config}" "${HOME}/${config}.backup"
        else
            # Same config already exists
            rm -r "${HOME:?}/${config:?}"
        fi
    fi
    ln -s "$(realpath git/"${config}")" "${HOME}"
done
