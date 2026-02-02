###############################################################################
# Basics                                                                      #
###############################################################################

ubuntu-core:
	echo "🖥 Operating System: Ubuntu"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f
	xargs sudo apt-get install -y < aptfiles/core.Aptfile

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
	xscript "scripts/dropbox.sh"

###############################################################################
# CLIs                                                                        #
###############################################################################

ubuntu-git: ubuntu-stow
	xargs sudo apt-get install -y < pkg/git/git.Aptfile

ubuntu-micro: ubuntu-stow
	xscript "pkg/micro/debian-micro.sh"

ubuntu-nano:
	sudo apt-get update
	sudo apt-get install -y nano

ubuntu-stow:
	sudo apt-get update
	sudo apt-get install -y stow

ubuntu-zsh: ubuntu-stow
	xscript "scripts/debian-zsh.sh"

###############################################################################
# Dev                                                                         #
###############################################################################

ubuntu-javascript:
	echo "dotfiles are installed, but not the runtime environments."

###############################################################################
# Misc                                                                        #
###############################################################################

ubuntu-locale-zhtw:
	xscript "scripts/debian-locale-zhtw.sh"

ubuntu-ssh:
	xscript "scripts/debian-ssh.sh"

ubuntu-tz-taipei:
	xscript "scripts/debian-tz-taipei.sh"
