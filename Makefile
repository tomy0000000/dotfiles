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
alias: core
	xscript "unix/alias.sh"
configs: stow
	xscript "unix/configs.sh"
git: $(OS)-git nano
	xscript "unix/git.sh"
jupyter: stow
	xscript "unix/jupyter.sh"

### macOS ###

macos-brew:
	exists brew || xscript "macos/brew.sh"

macos-mas: macos-brew
	exists mas || brew install mas

macos-core: macos-brew macos-mas
	echo "🖥 Operating System: macOS"
	exists realpath || brew install coreutils
	
macos-handful:
	brew bundle --no-lock --file "macos/lists/handful.Brewfile"

macos-nano: ;

macos-stow: macos-brew
	exists stow || brew install stow

macos-git: macos-brew
	exists git || brew install git git-extras
	
macos-touch-id-sudo:
	xscript "macos/touch_id_sudo.sh"

macos-service-workflow: stow
	xscript "macos/service_workflow.sh"

### Ubuntu ###

ubuntu-core:
	echo "🖥 Operating System: Ubuntu"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f
	xargs sudo apt-get install < ubuntu/apt.core
	
ubuntu-handful:
	echo "There is no handful util for ubuntu for now."

ubuntu-nano:
	sudo apt-get update
	sudo apt-get install -y nano

ubuntu-stow:
	sudo apt-get update
	sudo apt-get install -y stow

ubuntu-git:
	sudo apt-get install -y git git-extras

ubuntu-essential: ubuntu-core ubuntu-locale-zhtw ubuntu-tz-taipei ubuntu-ssh
	sudo apt-get install -y build-essential

ubuntu-locale-zhtw:
	xscript "ubuntu/locale-zhtw.sh"

ubuntu-tz-taipei:
	xscript "ubuntu/tz-taipei.sh"

ubuntu-dropbox: ubuntu-essential
	xscript "linux/dropbox.sh"

ubuntu-ssh:
	xscript "ubuntu/ssh.sh"

ubuntu-zsh:
	sudo apt-get update
	sudo apt-get install -y zsh
	sudo chsh -s "$(which zsh)"
