ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
SHELL = $(ROOT_DIR)/bin/make-shell
OS := $(shell distro)

all: $(OS)
macos: macos-core
ubuntu: ubuntu-core

ai-config: $(OS)-ai-config
core: $(OS)-core
clean: $(OS)-clean
cli-network: $(OS)-cli-network
dropbox: $(OS)-dropbox
git: $(OS)-git
javascript: $(OS)-javascript
micro: $(OS)-micro
mise: $(OS)-mise
nano: $(OS)-nano
starship: $(OS)-starship
stow: $(OS)-stow
zsh: $(OS)-zsh

ansible: stow
	stow --no-folding --dir 'pkg/ansible' --target "${HOME}" 'stow'
python: stow
	stow --no-folding --dir 'pkg/python' --target "${HOME}" 'stow'

include makefiles/*.mk
