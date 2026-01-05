SHELL = /bin/bash
OS := $(shell bin/distro)
PATH := bin:$(PATH)
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: clean git macos-brew

all: $(OS)
macos: macos-core
ubuntu: ubuntu-core

core: $(OS)-core
clean: $(OS)-clean
cli-network: $(OS)-cli-network
nano: $(OS)-nano
stow: $(OS)-stow
zsh: $(OS)-zsh

git: $(OS)-git
	stow --no-folding --target "${HOME}" 'git'
micro: $(OS)-micro
	stow --no-folding --dir 'pkg/micro' --target "${HOME}" 'stow'
ansible: stow
	stow --no-folding --target "${HOME}" 'ansible'
javascript: stow $(OS)-javascript
	stow --no-folding --dir 'pkg/javascript' --target "${HOME}" 'stow'
python: stow
	stow --no-folding --dir 'pkg/python' --target "${HOME}" 'stow'

include makefiles/*.mk
