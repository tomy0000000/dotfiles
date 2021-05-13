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

macos-stow: brew
	brew install stow

touch-id-sudo:
	xscript "scripts/touch_id_sudo.sh"

### Ubuntu ###

core-ubuntu:
	echo "🖥 Operating System: Ubuntu"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f
	xargs sudo apt-get install < ubuntu/apt.core

locale-zhtw:
	sudo apt-get update
	sudo apt-get install -y locales
	sudo locale-gen zh_TW
	sudo locale-gen zh_TW.UTF-8
	sudo dpkg-reconfigure --frontend=noninteractive locales
	sudo update-locale LANG="zh_TW.UTF-8" LANGUAGE="zh_TW"

tz-taipei:
	sudo apt-get update
	sudo ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
	sudo apt-get install -y tzdata
	sudo dpkg-reconfigure --frontend noninteractive tzdata

essential: core-ubuntu tz-taipei
	sudo apt-get install -y build-essential

ubuntu-stow:
	sudo apt-get update
	sudo apt-get install -y stow

zsh:
	sudo apt-get update
	sudo apt-get install -y zsh
	sudo chsh -s "$(which zsh)"

dropbox: essential
	xscript "scripts/dropbox.sh"

### Universal ###

stow: $(OS)-stow

alias:
	xscript "scripts/alias.sh"

configs: stow
	xscript "scripts/configs.sh"

jupyter: stow
	xscript "scripts/jupyter.sh"
