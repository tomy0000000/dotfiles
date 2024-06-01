#!/bin/bash
set -e
echo " Setting up git"

configs=".gitalias .gitattributes .gitconfig .gitignore_global .stCommitMsg"
git_dir="unix/git"

for config in ${configs}; do
	old-configs "${HOME}/${config}" "${git_dir}/${config}"
	ln -s "$(realpath ${git_dir}/"${config}")" "${HOME}"
done
