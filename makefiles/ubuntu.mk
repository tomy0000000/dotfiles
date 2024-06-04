ubuntu-core:
	echo "🖥 Operating System: Ubuntu"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f
	xargs sudo apt-get install < aptfiles/core.Aptfile
	
ubuntu-dropbox: ubuntu-essential
	xscript "scripts/dropbox.sh"

ubuntu-essential: ubuntu-core ubuntu-locale-zhtw ubuntu-tz-taipei ubuntu-ssh
	sudo apt-get install -y build-essential

ubuntu-git:
	xargs sudo apt-get install < aptfiles/git.Aptfile

ubuntu-handful:
	echo "There is no handful util for ubuntu for now."

ubuntu-locale-zhtw:
	xscript "scripts/debian-locale-zhtw.sh"

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

ubuntu-zsh:
	sudo apt-get update
	sudo apt-get install -y zsh
	sudo chsh -s "$(which zsh)"
