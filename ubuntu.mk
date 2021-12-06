ubuntu-core:
	echo "🖥 Operating System: Ubuntu"
	sudo apt-get update
	sudo apt-get upgrade -y
	sudo apt-get dist-upgrade -f
	xargs sudo apt-get install < ubuntu/apt.core
	
ubuntu-handful:
	echo "There is no handful util for ubuntu for now."

ubuntu-nano:
	sudo apt-get update
	sudo apt-get install -y nano

ubuntu-stow:
	sudo apt-get update
	sudo apt-get install -y stow

ubuntu-git:
	sudo apt-get install -y git git-extras

ubuntu-essential: ubuntu-core ubuntu-locale-zhtw ubuntu-tz-taipei ubuntu-ssh
	sudo apt-get install -y build-essential

ubuntu-locale-zhtw:
	xscript "ubuntu/locale-zhtw.sh"

ubuntu-tz-taipei:
	xscript "ubuntu/tz-taipei.sh"

ubuntu-dropbox: ubuntu-essential
	xscript "linux/dropbox.sh"

ubuntu-ssh:
	xscript "ubuntu/ssh.sh"

ubuntu-zsh:
	sudo apt-get update
	sudo apt-get install -y zsh
	sudo chsh -s "$(which zsh)"
