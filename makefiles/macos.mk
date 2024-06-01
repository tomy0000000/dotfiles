macos-brew:
	exists brew || xscript "macos/brew.sh"

macos-mas: macos-brew
	exists mas || brew install mas

macos-core: macos-brew macos-mas
	echo "🖥 Operating System: macOS"
	exists realpath || brew install coreutils
	
macos-handful:
	brew bundle --no-lock --file "brewfiles/handful.Brewfile"

macos-nano: ;

macos-stow: macos-brew
	exists stow || brew install stow

macos-git: macos-brew
	exists git || brew install git git-extras
	
macos-touch-id-sudo:
	xscript "macos/touch_id_sudo.sh"

macos-service-workflow: stow
	xscript "macos/service_workflow.sh"
