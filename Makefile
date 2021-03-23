SHELL = /bin/bash
OS := $(shell bin/distro)
PATH := bin:$(PATH)

.PHONY: alias configs jupyter

all: $(OS)
macos: core-macos brew
ubuntu: core-ubuntu zsh

### macOS ###

core-macos:
	echo "🖥 Operating System: macOS"
	xcode-select --install

brew:
	xscript "scripts/homebrew.sh"

### Ubuntu ###

core-ubuntu:
	echo "🖥 Operating System: Ubuntu"
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f

zsh:
	apt-get update
	apt-get install zsh -y
	chsh -s "/bin/zsh"

### Universal ###

alias:
	xscript "scripts/alias.sh"

configs:
	for config in "configs/*"; do \
		echo "${config}"; \
		if [ -f "${HOME}/${config}" ]; then \
			echo "${config} already exists, backed up."; \
			mv "${HOME}/${config}" "${HOME}/${config}.backup"; \
		fi; \
	done
	stow --restow --target "${HOME}" "configs"

jupyter:
	mkdir -p "${HOME}/.jupyter/lab"
	if [ -d "${HOME}/.jupyter/lab/user-settings" ]; then \
		echo "${HOME}/.jupyter/lab/user-settings already exists, backed up."; \
		mv "${HOME}/.jupyter/lab/user-settings" "${HOME}/.jupyter/lab/user-settings.backup"; \
	fi
	stow --target "${HOME}/.jupyter" "jupyter"
