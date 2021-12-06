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

include macos.mk
include ubuntu.mk
