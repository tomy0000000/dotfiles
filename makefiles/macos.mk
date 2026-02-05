###############################################################################
# Basics                                                                      #
###############################################################################

macos-core: macos-brew macos-stow macos-zsh

macos-brew:
	run "pkg/brew/macos-brew.sh"

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

macos-app-dev: git macos-brew macos-iterm macos-sublime macos-terminal macos-vscode macos-xcode
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
	run "pkg/macos-alfred/macos-alfred.sh"

macos-appcleaner: macos-brew
	brew install --cask appcleaner
	defaults import net.freemacsoft.AppCleaner pkg/macos-appcleaner/net.freemacsoft.AppCleaner.plist

macos-cleanshot: macos-brew
	brew bundle --file brewfiles/cleanshot.Brewfile
	run "scripts/macos-cleanshot.sh"

macos-finder:
	run "scripts/macos-finder.sh"

macos-hammerspoon: macos-brew macos-stow
	brew install --cask hammerspoon
	stow --no-folding --dir 'pkg' --target "${HOME}" 'macos-hammerspoon'

macos-iterm: macos-brew
	brew bundle --file pkg/macos-iterm/macos-iterm.Brewfile
	exists imgcat || (run "pkg/macos-iterm/macos-iterm.sh")

macos-markedit: macos-brew
	brew bundle --file brewfiles/markedit.Brewfile
	run "scripts/macos-markedit.sh"

macos-one-password: macos-brew
	brew bundle --file brewfiles/one-password.Brewfile

macos-popclip: macos-brew
	brew bundle --file brewfiles/popclip.Brewfile
	run "scripts/macos-popclip.sh"

macos-sublime: macos-brew macos-stow
	brew install --cask sublime-text
	run "pkg/sublime/macos-sublime.sh"

macos-terminal: macos-brew
	brew bundle --file brewfiles/terminal.Brewfile

macos-tower: macos-brew macos-git
	brew install --cask tower
	run "pkg/macos-tower/macos-tower.sh"

macos-vscode: macos-brew
	brew install --cask visual-studio-code
	run "pkg/vscode/macos-vscode.sh"

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
	brew bundle --file pkg/git/git.Brewfile

macos-micro: macos-brew
	brew install micro

macos-nano: ;

macos-shellcheck: macos-brew macos-stow
	exists shellcheck || brew install shellcheck
	stow --no-folding --dir 'pkg/shellcheck' --target "${HOME}" 'stow'

macos-stow: macos-brew macos-clean
	$(eval BREW_BIN := $(shell bin/brew_bin))
	exists stow || ${BREW_BIN}/brew install stow

macos-zsh: macos-brew macos-stow
	$(eval BREW_BIN := $(shell bin/brew_bin))
	${BREW_BIN}/brew bundle --file brewfiles/zsh.Brewfile
	run "scripts/macos-zsh.sh"

###############################################################################
# Dev                                                                         #
###############################################################################

macos-c-cpp: macos-brew
	brew install cling

macos-javascript:
	echo "dotfiles are installed, but not the runtime environments."

macos-perl: macos-stow
	stow --no-folding --dir 'pkg/perl' --target "${HOME}" 'stow'
	run "pkg/perl/macos-perl.sh"

###############################################################################
# Misc                                                                        #
###############################################################################

macos-file-handler: macos-duti
	run "scripts/macos-file-handler.sh"

macos-font: macos-brew
	brew bundle --file pkg/macos-font/macos-font.Brewfile
	cp -r pkg/macos-font/collection/ "${HOME}/Library/FontCollections"

macos-icon: macos-cli-useful
	run "scripts/macos-icons.sh"

macos-quicklook: macos-brew
	brew bundle --file brewfiles/ext-quicklook.Brewfile

macos-screensaver: macos-brew
	brew bundle --file brewfiles/ext-screensaver.Brewfile

macos-service-workflow: macos-stow
	stow --dir 'pkg' --target "${HOME}/Library/Services" 'macos-services'

macos-settings:
	run "scripts/macos-settings.sh"

macos-touch-id-sudo:
	run "scripts/macos-touch-id-sudo.sh"
