SHELL = /bin/bash
OS := $(shell bin/distro)
PATH := bin:$(PATH)

.PHONY: clean git macos-brew

all: $(OS)
macos: macos-core
ubuntu: ubuntu-core

core: $(OS)-core
clean: $(OS)-clean
cli-network: $(OS)-cli-network
git: $(OS)-git
handful: $(OS)-handful
micro: $(OS)-micro
nano: $(OS)-nano
stow: $(OS)-stow
zsh: $(OS)-zsh

ansible: stow
	stow --no-folding --target "${HOME}" 'ansible'
javascript: stow
	stow --no-folding --target "${HOME}" 'javascript'
python: stow
	stow --no-folding --target "${HOME}" 'python'
ruby: stow
	stow --no-folding --target "${HOME}" 'ruby'

include makefiles/*.mk
