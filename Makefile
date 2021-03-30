SHELL = /bin/bash
OS := $(shell bin/distro)
PATH := bin:$(PATH)

.PHONY: alias configs jupyter

all: $(OS)
macos: core-macos brew
ubuntu: core-ubuntu

### macOS ###

core-macos:
	echo "🖥 Operating System: macOS"
	sudo xcode-select --install

brew:
	xscript "scripts/homebrew.sh"

### Ubuntu ###

core-ubuntu:
	echo "🖥 Operating System: Ubuntu"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f

essential:
	sudo apt-get update
	sudo ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
	sudo apt-get install -y build-essential curl git tzdata wget
	sudo dpkg-reconfigure --frontend noninteractive tzdata

zsh:
	sudo apt-get update
	sudo apt-get install -y zsh
	sudo chsh -s "/bin/zsh"

dropbox: essential
	xscript "scripts/dropbox.sh"

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
