ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL = $(ROOT_DIR)/bin/make-shell
OS := $(shell distro)
PATH := bin:$(PATH)

all: $(OS)
macos: macos-core
ubuntu: ubuntu-core

core: $(OS)-core
clean: $(OS)-clean
cli-network: $(OS)-cli-network
dropbox: $(OS)-dropbox
git: $(OS)-git
nano: $(OS)-nano
stow: $(OS)-stow
zsh: $(OS)-zsh

micro: $(OS)-micro
	stow --no-folding --dir 'pkg/micro' --target "${HOME}" 'stow'
ansible: stow
	stow --no-folding --dir 'pkg/ansible' --target "${HOME}" 'stow'
javascript: stow $(OS)-javascript
	stow --no-folding --dir 'pkg/javascript' --target "${HOME}" 'stow'
python: stow
	stow --no-folding --dir 'pkg/python' --target "${HOME}" 'stow'

include makefiles/*.mk
