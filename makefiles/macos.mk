macos-brew:
	exists brew || xscript "scripts/macos-brew.sh"

macos-mas: macos-brew
	exists mas || brew install mas

macos-core: macos-brew macos-mas
	echo "🖥 Operating System: macOS"
	exists realpath || brew install coreutils

macos-handful:
	brew bundle --no-lock --file 'brewfiles/handful.Brewfile'

macos-nano: ;

macos-stow: macos-brew
	exists stow || brew install stow

# This is a full suite of git plugins and configurations
# Most other target that requires git don't need this
macos-git: macos-brew
	exists git || brew install git git-extras

macos-touch-id-sudo:
	xscript "scripts/macos-touch-id-sudo.sh"

macos-service-workflow: macos-brew
	exists stow || brew install stow
	stow --target "${HOME}/Library/Services" 'macos-services'

macos-chromium-app-icon: macos-brew
	exists fileicon || brew install fileicon
	xscript "scripts/macos-chromium-app-icon.sh"

macos-zsh: macos-brew
	brew bundle --no-lock --file 'brewfiles/zsh.Brewfile'
	xscript "scripts/macos-zsh.sh"
