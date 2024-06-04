SHELL = /bin/bash
OS := $(shell bin/distro)
PATH := bin:$(PATH)

.PHONY: alias macos-brew configs git jupyter

all: $(OS)
macos: macos-core
ubuntu: ubuntu-core

core: $(OS)-core
git: $(OS)-git
handful: $(OS)-handful
nano: $(OS)-nano
stow: $(OS)-stow
zsh: $(OS)-zsh

configs: stow
	xscript "scripts/configs.sh"
jupyter: stow
	xscript "scripts/jupyter.sh"

include makefiles/*.mk
