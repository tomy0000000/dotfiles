###############################################################################
# Basics                                                                      #
###############################################################################

macos-core: macos-brew macos-stow macos-zsh

macos-brew:
	$(eval BREW_BIN := $(shell bin/brew_bin))
	exists brew || xscript "scripts/macos-brew.sh"
	${BREW_BIN}/brew tap homebrew/bundle
	${BREW_BIN}/brew bundle --no-lock --file brewfiles/core.Brewfile
	${BREW_BIN}/stow --no-folding --target "${HOME}" macos-brew
	@if ${BREW_BIN}/brew autoupdate status | grep -q "stopped"; then \
		${BREW_BIN}/brew autoupdate start; \
	fi

macos-clean:
	find . -name ".DS_Store" -delete

###############################################################################
# App Suite                                                                   #
###############################################################################

macos-app-private: macos-brew macos-app-dev macos-one-password macos-appcleaner macos-alfred macos-popclip macos-markedit
	brew bundle --no-lock --file brewfiles/app-essential.Brewfile
	brew bundle --no-lock --file brewfiles/app-private.Brewfile
	brew bundle --no-lock --file brewfiles/app-design.Brewfile
	brew bundle --no-lock --file brewfiles/app-multimedia.Brewfile
	brew bundle --no-lock --file brewfiles/app-productivity.Brewfile
	brew bundle --no-lock --file brewfiles/app-social.Brewfile
	brew bundle --no-lock --file brewfiles/app-utility.Brewfile

macos-app-work: macos-brew macos-app-dev macos-appcleaner macos-alfred macos-popclip
	brew bundle --no-lock --file brewfiles/app-essential.Brewfile

macos-app-dev: git macos-brew macos-iterm macos-sublime macos-terminal macos-xcode
	brew bundle --no-lock --file brewfiles/app-dev.Brewfile

###############################################################################
# CLI Suite                                                                   #
###############################################################################

macos-cli-network: macos-brew
	brew bundle --no-lock --file brewfiles/cli-network.Brewfile

macos-cli-useful: macos-brew
	brew bundle --no-lock --file brewfiles/cli-useful.Brewfile

###############################################################################
# Apps                                                                        #
###############################################################################

macos-alfred: macos-brew
	brew bundle --no-lock --file brewfiles/alfred.Brewfile
	xscript "scripts/macos-alfred.sh"

macos-appcleaner: macos-brew
	brew bundle --no-lock --file brewfiles/appcleaner.Brewfile
	defaults import net.freemacsoft.AppCleaner macos-appcleaner/net.freemacsoft.AppCleaner.plist

macos-cleanshot: macos-brew
	brew bundle --no-lock --file brewfiles/cleanshot.Brewfile
	xscript "scripts/macos-cleanshot.sh"

macos-finder:
	xscript "scripts/macos-finder.sh"

macos-hammerspoon: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/hammerspoon.Brewfile
	stow --no-folding --target "${HOME}" 'hammerspoon'

macos-iterm: macos-brew
	brew bundle --no-lock --file brewfiles/iterm.Brewfile
	exists imgcat || xscript "scripts/macos-iterm.sh"

macos-markedit: macos-brew
	brew bundle --no-lock --file brewfiles/markedit.Brewfile
	xscript "scripts/macos-markedit.sh"

macos-one-password: macos-brew
	brew bundle --no-lock --file brewfiles/one-password.Brewfile

macos-popclip: macos-brew
	brew bundle --no-lock --file brewfiles/popclip.Brewfile
	xscript "scripts/macos-popclip.sh"

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

macos-xcode: macos-brew
	brew bundle --no-lock --file brewfiles/xcode.Brewfile

###############################################################################
# CLIs                                                                        #
###############################################################################

macos-docker: macos-brew
	brew bundle --no-lock --file brewfiles/docker.Brewfile

# This is a full suite of git plugins and configurations
# Most other target that requires git don't need this
macos-git: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/git.Brewfile

macos-micro: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/micro.Brewfile

macos-nano: ;

macos-shellcheck: macos-brew macos-stow
	exists shellcheck || brew install shellcheck
	stow --no-folding --target "${HOME}" 'shellcheck'

macos-stow: macos-brew macos-clean
	$(eval BREW_BIN := $(shell bin/brew_bin))
	exists stow || ${BREW_BIN}/brew install stow

macos-zsh: macos-brew macos-stow
	$(eval BREW_BIN := $(shell bin/brew_bin))
	${BREW_BIN}/brew bundle --no-lock --file brewfiles/zsh.Brewfile
	xscript "scripts/macos-zsh.sh"
	mkdir -p "${HOME}/.config"
	${BREW_BIN}/stow --dir=zsh --no-folding --target "${HOME}/.config" .config
	ln -s .dotfiles/zsh/.zshenv "${HOME}/.zshenv"

###############################################################################
# Dev                                                                         #
###############################################################################

macos-javascript: macos-brew
	brew bundle --no-lock --file brewfiles/javascript.Brewfile
	echo "Installed node with `pnpm env add --global lts`"

macos-perl:
	stow --no-folding --target "${HOME}" 'perl'
	xscript "scripts/macos-perl.sh"

###############################################################################
# Misc                                                                        #
###############################################################################

macos-font: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/ext-font.Brewfile
	cp -r macos-font/collection/ "${HOME}/Library/FontCollections"

macos-icon: macos-cli-useful
	xscript "scripts/macos-icons.sh"

macos-quicklook: macos-brew
	brew bundle --no-lock --file brewfiles/ext-quicklook.Brewfile

macos-screensaver: macos-brew
	brew bundle --no-lock --file brewfiles/ext-screensaver.Brewfile

macos-service-workflow: macos-stow
	stow --target "${HOME}/Library/Services" 'macos-services'

macos-settings:
	xscript "scripts/macos-settings.sh"

macos-touch-id-sudo:
	xscript "scripts/macos-touch-id-sudo.sh"
