SHELL = /bin/bash
OS := $(shell bin/distro)
PATH := bin:$(PATH)

.PHONY: macos-brew git

all: $(OS)
macos: macos-core
ubuntu: ubuntu-core

core: $(OS)-core
git: $(OS)-git
handful: $(OS)-handful
nano: $(OS)-nano
stow: $(OS)-stow
zsh: $(OS)-zsh

javascript: stow
	stow --no-folding --target "${HOME}" 'javascript'
python: stow
	stow --no-folding --target "${HOME}" 'python'

include makefiles/*.mk
