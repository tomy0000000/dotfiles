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
	xargs sudo apt-get install -y < aptfiles/cli-network.Aptfile

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

ubuntu-nano:
	sudo apt-get update
	sudo apt-get install -y nano

ubuntu-stow:
	sudo apt-get update
	sudo apt-get install -y stow

ubuntu-zsh: ubuntu-stow
	run "scripts/debian-zsh.sh"

###############################################################################
# Dev                                                                         #
###############################################################################

ubuntu-javascript:
	echo "dotfiles are installed, but not the runtime environments."

###############################################################################
# Misc                                                                        #
###############################################################################

ubuntu-locale-zhtw:
	run "scripts/debian-locale-zhtw.sh"

ubuntu-ssh:
	run "scripts/debian-ssh.sh"

ubuntu-tz-taipei:
	run "scripts/debian-tz-taipei.sh"
