macos-app-private: macos-brew macos-app-dev macos-one-password macos-appcleaner macos-alfred macos-markedit
	brew bundle --no-lock --file brewfiles/app-essential.Brewfile
	brew bundle --no-lock --file brewfiles/app-private.Brewfile
	brew bundle --no-lock --file brewfiles/app-design.Brewfile
	brew bundle --no-lock --file brewfiles/app-multimedia.Brewfile
	brew bundle --no-lock --file brewfiles/app-productivity.Brewfile
	brew bundle --no-lock --file brewfiles/app-social.Brewfile
	brew bundle --no-lock --file brewfiles/app-utility.Brewfile

macos-app-work: macos-brew macos-app-dev macos-appcleaner macos-alfred
	brew bundle --no-lock --file brewfiles/app-essential.Brewfile

macos-app-dev: macos-brew macos-iterm macos-xcode git
	brew bundle --no-lock --file brewfiles/app-dev.Brewfile

macos-alfred: macos-brew
	brew bundle --no-lock --file brewfiles/alfred.Brewfile
	xscript "scripts/macos-alfred.sh"

macos-appcleaner: macos-brew
	brew bundle --no-lock --file brewfiles/appcleaner.Brewfile
	defaults import net.freemacsoft.AppCleaner macos-appcleaner/net.freemacsoft.AppCleaner.plist

macos-brew:
	$(eval BREW_BIN := $(shell bin/brew_bin))
	exists brew || xscript "scripts/macos-brew.sh"
	${BREW_BIN}/brew tap homebrew/bundle
	${BREW_BIN}/brew bundle --no-lock --file brewfiles/core.Brewfile
	${BREW_BIN}/stow --no-folding --target "${HOME}" macos-brew

macos-clean:
	find . -name ".DS_Store" -delete

macos-cleanshot: macos-brew
	brew bundle --no-lock --file brewfiles/cleanshot.Brewfile
	xscript "scripts/macos-cleanshot.sh"

macos-core: macos-brew macos-stow macos-zsh

macos-cli-network: macos-brew
	brew bundle --no-lock --file brewfiles/cli-network.Brewfile

macos-docker: macos-brew
	brew bundle --no-lock --file brewfiles/docker.Brewfile

macos-finder:
	xscript "scripts/macos-finder.sh"

macos-font: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/ext-font.Brewfile
	cp -r macos-font/collection/ "${HOME}/Library/FontCollections"

# This is a full suite of git plugins and configurations
# Most other target that requires git don't need this
macos-git: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/git.Brewfile
	stow --no-folding --target "${HOME}" 'git'

macos-hammerspoon: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/hammerspoon.Brewfile
	stow --no-folding --target "${HOME}" 'hammerspoon'

macos-handful: macos-brew
	brew bundle --no-lock --file brewfiles/handful.Brewfile

macos-icon: macos-brew
	exists fileicon || brew install fileicon
	xscript "scripts/macos-icons.sh"

macos-iterm: macos-brew
	brew bundle --no-lock --file brewfiles/iterm.Brewfile
	exists imgcat || xscript "scripts/macos-iterm.sh"

macos-markedit: macos-brew
	brew bundle --no-lock --file brewfiles/markedit.Brewfile
	xscript "scripts/macos-markedit.sh"

macos-micro: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/micro.Brewfile
	stow --no-folding --target "${HOME}" 'micro'

macos-nano: ;

macos-one-password: macos-brew
	brew bundle --no-lock --file brewfiles/one-password.Brewfile

macos-service-workflow: macos-stow
	stow --target "${HOME}/Library/Services" 'macos-services'

macos-shellcheck: macos-brew macos-stow
	exists shellcheck || brew install shellcheck
	stow --no-folding --target "${HOME}" 'shellcheck'

macos-stow: macos-brew macos-clean
	$(eval BREW_BIN := $(shell bin/brew_bin))
	exists stow || ${BREW_BIN}/brew install stow

macos-sublime: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/sublime.Brewfile
	xscript "scripts/macos-sublime.sh"
	stow --no-folding --target "${HOME}/Library/Application Support/Sublime Text" 'sublime'
	stow --no-folding --dir 'private' --target "${HOME}/Library/Application Support/Sublime Text" 'sublime'

macos-terminal: macos-brew
	brew bundle --no-lock --file brewfiles/terminal.Brewfile

macos-tower: macos-brew macos-git
	brew bundle --no-lock --file brewfiles/tower.Brewfile
	xscript "scripts/macos-tower.sh"

macos-touch-id-sudo:
	xscript "scripts/macos-touch-id-sudo.sh"

macos-xcode: macos-brew
	brew bundle --no-lock --file brewfiles/xcode.Brewfile

macos-zsh: macos-brew macos-stow
	$(eval BREW_BIN := $(shell bin/brew_bin))
	${BREW_BIN}/brew bundle --no-lock --file brewfiles/zsh.Brewfile
	xscript "scripts/macos-zsh.sh"
	${BREW_BIN}/stow --no-folding --target "${HOME}" zsh
