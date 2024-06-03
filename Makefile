SHELL = /bin/bash
OS := $(shell bin/distro)
PATH := bin:$(PATH)

.PHONY: alias macos-brew configs git jupyter

all: $(OS)
macos: macos-core
ubuntu: ubuntu-core

core: $(OS)-core
handful: $(OS)-handful
nano: $(OS)-nano
stow: $(OS)-stow
alias: core
	xscript "scripts/alias.sh"
configs: stow
	xscript "scripts/configs.sh"
git: $(OS)-git nano
	xscript "scripts/git.sh"
jupyter: stow
	xscript "scripts/jupyter.sh"

include makefiles/*.mk
