SHELL = /bin/bash
PATH := $(DOTFILES_DIR)/bin:$(PATH)

.PHONY: configs jupyter

all: $(OS)
macos: core-macos
ubuntu: core-ubuntu

### macOS ###

core-macos:
	echo "macOS"

### Ubuntu ###

core-ubuntu:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f

### Universal ###

zsh:
	echo "zsh"
	
alias:
	echo "alias"

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
	@if [ -d "${HOME}/.jupyter/lab/user-settings" ]; then \
		echo "${HOME}/.jupyter/lab/user-settings already exists, backed up."; \
		mv "${HOME}/.jupyter/lab/user-settings" "${HOME}/.jupyter/lab/user-settings.backup"; \
	fi
	stow --restow --dir "jupyter" --target "${HOME}/.jupyter/lab" "lab"
