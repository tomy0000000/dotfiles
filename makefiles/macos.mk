###############################################################################
# Basics                                                                      #
###############################################################################

macos-core: macos-brew macos-stow macos-zsh

macos-brew:
	$(eval BREW_BIN := $(shell bin/brew_bin))
	exists brew || xscript "scripts/macos-brew.sh"
	${BREW_BIN}/brew bundle --file brewfiles/core.Brewfile
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
	brew bundle --file brewfiles/app-essential.Brewfile
	brew bundle --file brewfiles/app-private.Brewfile
	brew bundle --file brewfiles/app-design.Brewfile
	brew bundle --file brewfiles/app-multimedia.Brewfile
	brew bundle --file brewfiles/app-productivity.Brewfile
	brew bundle --file brewfiles/app-social.Brewfile
	brew bundle --file brewfiles/app-utility.Brewfile

macos-app-work: macos-brew macos-app-dev macos-appcleaner macos-alfred macos-popclip
	brew bundle --file brewfiles/app-essential.Brewfile

macos-app-dev: git macos-brew macos-iterm macos-sublime macos-terminal macos-xcode
	brew bundle --file brewfiles/app-dev.Brewfile

###############################################################################
# CLI Suite                                                                   #
###############################################################################

macos-cli-network: macos-brew
	brew bundle --file brewfiles/cli-network.Brewfile

macos-cli-useful: macos-brew
	brew bundle --file brewfiles/cli-useful.Brewfile

###############################################################################
# Apps                                                                        #
###############################################################################

macos-alfred: macos-brew
	brew bundle --file brewfiles/alfred.Brewfile
	xscript "scripts/macos-alfred.sh"

macos-appcleaner: macos-brew
	brew install --cask appcleaner
	defaults import net.freemacsoft.AppCleaner pkg/macos-appcleaner/net.freemacsoft.AppCleaner.plist

macos-cleanshot: macos-brew
	brew bundle --file brewfiles/cleanshot.Brewfile
	xscript "scripts/macos-cleanshot.sh"

macos-finder:
	xscript "scripts/macos-finder.sh"

macos-hammerspoon: macos-brew macos-stow
	brew install --cask hammerspoon
	stow --no-folding --dir 'pkg' --target "${HOME}" 'macos-hammerspoon'

macos-iterm: macos-brew
	brew bundle --file pkg/macos-iterm/macos-iterm.Brewfile
	exists imgcat || xscript "pkg/macos-iterm/macos-iterm.sh"

macos-markedit: macos-brew
	brew bundle --file brewfiles/markedit.Brewfile
	xscript "scripts/macos-markedit.sh"

macos-one-password: macos-brew
	brew bundle --file brewfiles/one-password.Brewfile

macos-popclip: macos-brew
	brew bundle --file brewfiles/popclip.Brewfile
	xscript "scripts/macos-popclip.sh"

macos-sublime: macos-brew macos-stow
	brew bundle --file brewfiles/sublime.Brewfile
	xscript "scripts/macos-sublime.sh"
	stow --no-folding --target "${HOME}/Library/Application Support/Sublime Text" 'sublime'
	stow --no-folding --dir 'private' --target "${HOME}/Library/Application Support/Sublime Text" 'sublime'

macos-terminal: macos-brew
	brew bundle --file brewfiles/terminal.Brewfile

macos-tower: macos-brew macos-git
	brew install --cask tower
	xscript "pkg/macos-tower/macos-tower.sh"

macos-xcode: macos-brew
	brew bundle --file brewfiles/xcode.Brewfile

###############################################################################
# CLIs                                                                        #
###############################################################################

macos-docker: macos-brew
	brew bundle --file brewfiles/docker.Brewfile

macos-duti: macos-brew
	brew bundle --file brewfiles/duti.Brewfile

# This is a full suite of git plugins and configurations
# Most other target that requires git don't need this
macos-git: macos-brew
	brew bundle --file brewfiles/git.Brewfile

macos-micro: macos-brew
	brew install micro

macos-nano: ;

macos-shellcheck: macos-brew macos-stow
	exists shellcheck || brew install shellcheck
	stow --no-folding --target "${HOME}" 'shellcheck'

macos-stow: macos-brew macos-clean
	$(eval BREW_BIN := $(shell bin/brew_bin))
	exists stow || ${BREW_BIN}/brew install stow

macos-zsh: macos-brew macos-stow
	$(eval BREW_BIN := $(shell bin/brew_bin))
	${BREW_BIN}/brew bundle --file brewfiles/zsh.Brewfile
	xscript "scripts/macos-zsh.sh"

###############################################################################
# Dev                                                                         #
###############################################################################

macos-c-cpp: macos-brew
	brew install cling

macos-javascript: macos-brew
	brew bundle --file brewfiles/javascript.Brewfile
	echo "Installed node with `pnpm env add --global lts`"

macos-perl: macos-stow
	stow --no-folding --target "${HOME}" 'perl'
	xscript "scripts/macos-perl.sh"

###############################################################################
# Misc                                                                        #
###############################################################################

macos-file-handler: macos-duti
	xscript "scripts/macos-file-handler.sh"

macos-font: macos-brew
	brew bundle --file pkg/macos-font/macos-font.Brewfile
	cp -r pkg/macos-font/collection/ "${HOME}/Library/FontCollections"

macos-icon: macos-cli-useful
	xscript "scripts/macos-icons.sh"

macos-quicklook: macos-brew
	brew bundle --file brewfiles/ext-quicklook.Brewfile

macos-screensaver: macos-brew
	brew bundle --file brewfiles/ext-screensaver.Brewfile

macos-service-workflow: macos-stow
	stow --dir 'pkg' --target "${HOME}/Library/Services" 'macos-services'

macos-settings:
	xscript "scripts/macos-settings.sh"

macos-touch-id-sudo:
	xscript "scripts/macos-touch-id-sudo.sh"
