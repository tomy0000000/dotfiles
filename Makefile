SHELL = /bin/bash
OS := $(shell bin/distro)
PATH := bin:$(PATH)

.PHONY: alias configs jupyter

all: $(OS)
macos: macos-core brew
ubuntu: ubuntu-core

### macOS ###

macos-core:
	echo "🖥 Operating System: macOS"
	sudo xcode-select --install

brew: macos-core
	xscript "scripts/homebrew.sh"

macos-stow: brew
	brew install stow

touch-id-sudo:
	xscript "scripts/touch_id_sudo.sh"

### Ubuntu ###

ubuntu-core:
	echo "🖥 Operating System: Ubuntu"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f
	xargs sudo apt-get install < ubuntu/apt.core

ubuntu-essential: ubuntu-core locale-zhtw tz-taipei ssh
	sudo apt-get install -y build-essential

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

ssh:
	xscript "scripts/ssh.sh"

ubuntu-stow:
	sudo apt-get update
	sudo apt-get install -y stow

ubuntu-zsh:
	sudo apt-get update
	sudo apt-get install -y zsh
	sudo chsh -s "$(which zsh)"

dropbox: ubuntu-essential
	xscript "scripts/dropbox.sh"

### Universal ###

stow: $(OS)-stow

alias:
	xscript "scripts/alias.sh"

configs: stow
	xscript "scripts/configs.sh"

jupyter: stow
	xscript "scripts/jupyter.sh"
