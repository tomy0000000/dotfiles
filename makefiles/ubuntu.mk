ubuntu-core:
	echo "🖥 Operating System: Ubuntu"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f
	xargs sudo apt-get install -y < aptfiles/core.Aptfile

ubuntu-clean: ;

ubuntu-cli-network:
	xargs sudo apt-get install -y < aptfiles/cli-network.Aptfile

ubuntu-dropbox: ubuntu-essential
	xscript "scripts/dropbox.sh"

ubuntu-essential: ubuntu-core ubuntu-locale-zhtw ubuntu-tz-taipei ubuntu-ssh
	sudo apt-get install -y build-essential

ubuntu-git: ubuntu-stow
	xargs sudo apt-get install -y < aptfiles/git.Aptfile

ubuntu-javascript:
	echo "NOT IMPLEMENTED!"

ubuntu-locale-zhtw:
	xscript "scripts/debian-locale-zhtw.sh"

ubuntu-micro: ubuntu-stow
	xscript "scripts/debian-micro.sh"

ubuntu-nano:
	sudo apt-get update
	sudo apt-get install -y nano

ubuntu-ssh:
	xscript "scripts/debian-ssh.sh"

ubuntu-stow:
	sudo apt-get update
	sudo apt-get install -y stow

ubuntu-tz-taipei:
	xscript "scripts/debian-tz-taipei.sh"

ubuntu-zsh: ubuntu-stow
	xscript "scripts/debian-zsh.sh"
