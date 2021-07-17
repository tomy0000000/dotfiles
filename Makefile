SHELL = /bin/bash
OS := $(shell bin/distro)
PATH := bin:$(PATH)

.PHONY: alias brew configs git jupyter

all: $(OS)
macos: macos-core
ubuntu: ubuntu-core

core: $(OS)-core
handful: $(OS)-handful
nano: $(OS)-nano
stow: $(OS)-stow

### macOS ###

macos-brew:
	exists brew || xscript "scripts/homebrew.sh"

macos-mas: macos-brew
	exists mas || brew install mas

macos-core: macos-brew macos-mas
	echo "🖥 Operating System: macOS"
	exists realpath || brew install coreutils

macos-nano: ;

macos-stow: macos-brew
	exists stow || brew install stow
	
macos-handful:
	brew bundle --no-lock --file "macos/lists/handful.Brewfile"
	
macos-touch-id-sudo:
	xscript "scripts/touch_id_sudo.sh"

macos-service-workflow: stow
	xscript "scripts/service_workflow.sh"

### Ubuntu ###

ubuntu-core:
	echo "🖥 Operating System: Ubuntu"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f
	xargs sudo apt-get install < ubuntu/apt.core

ubuntu-essential: ubuntu-core ubuntu-locale-zhtw ubuntu-tz-taipei ubuntu-ssh
	sudo apt-get install -y build-essential

ubuntu-locale-zhtw:
	sudo apt-get update
	sudo apt-get install -y locales
	sudo locale-gen zh_TW
	sudo locale-gen zh_TW.UTF-8
	sudo dpkg-reconfigure --frontend=noninteractive locales
	sudo update-locale LANG="zh_TW.UTF-8" LANGUAGE="zh_TW"

ubuntu-tz-taipei:
	sudo apt-get update
	sudo ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
	sudo apt-get install -y tzdata
	sudo dpkg-reconfigure --frontend noninteractive tzdata

ubuntu-ssh:
	xscript "scripts/ssh.sh"

ubuntu-nano:
	sudo apt-get update
	sudo apt-get install -y nano

ubuntu-stow:
	sudo apt-get update
	sudo apt-get install -y stow
	
ubuntu-handful:
	echo "There is no handful util for ubuntu for now."

ubuntu-zsh:
	sudo apt-get update
	sudo apt-get install -y zsh
	sudo chsh -s "$(which zsh)"

ubuntu-dropbox: ubuntu-essential
	xscript "scripts/dropbox.sh"

### Universal ###

alias: core
	xscript "scripts/alias.sh"

configs: stow
	xscript "scripts/configs.sh"

git: nano
	xscript "scripts/git.sh"

jupyter: stow
	xscript "scripts/jupyter.sh"
