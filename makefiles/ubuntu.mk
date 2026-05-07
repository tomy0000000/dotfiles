###############################################################################
# Basics                                                                      #
###############################################################################

ubuntu-core: ubuntu-stow
	run "pkg/core/debian-core.sh"

ubuntu-clean: ;

###############################################################################
# App Suite                                                                   #
###############################################################################

ubuntu-essential: ubuntu-core ubuntu-locale-zhtw ubuntu-tz-taipei ubuntu-ssh
	sudo apt-get install -y build-essential

###############################################################################
# CLI Suite                                                                   #
###############################################################################

ubuntu-cli-network:
	run "pkg/cli-network/debian-cli-network.sh"

ubuntu-cli-pipe:
	run "pkg/cli-pipe/debian-cli-pipe.sh"

###############################################################################
# Apps                                                                        #
###############################################################################

ubuntu-dropbox: ubuntu-essential
	run "pkg/dropbox/ubuntu-dropbox.sh"

###############################################################################
# CLIs                                                                        #
###############################################################################

ubuntu-git:
	run "pkg/git/debian-git.sh"

ubuntu-micro: ubuntu-stow
	run "pkg/micro/debian-micro.sh"

ubuntu-mise:
	run "pkg/mise/debian-mise.sh"

ubuntu-nano:
	sudo apt-get update
	sudo apt-get install -y nano

ubuntu-starship:
	run "pkg/starship/debian-starship.sh"

ubuntu-stow:
	run "pkg/stow/debian-stow.sh"

ubuntu-zsh: ubuntu-stow
	run "pkg/zsh/debian-zsh.sh"

###############################################################################
# Dev                                                                         #
###############################################################################

ubuntu-javascript: ubuntu-stow
	run "pkg/javascript/debian-javascript.sh"

###############################################################################
# Misc                                                                        #
###############################################################################

ubuntu-ai-config: ubuntu-stow
	run "pkg/ai-config/ai-config.sh"

ubuntu-locale-zhtw:
	run "pkg/locale-zhtw/debian-locale-zhtw.sh"

ubuntu-ssh:
	run "pkg/ssh/debian-ssh.sh"

ubuntu-tz-taipei:
	run "pkg/tz-taipei/debian-tz-taipei.sh"
