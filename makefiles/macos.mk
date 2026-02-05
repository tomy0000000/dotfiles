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

macos-app-private: macos-brew macos-app-dev macos-app-work macos-one-password macos-appcleaner macos-alfred macos-dropbox macos-popclip macos-markedit
	run "pkg/macos-app-private/macos-app-private.sh"

macos-app-work: macos-brew macos-app-dev macos-appcleaner macos-alfred macos-popclip

macos-app-dev: git macos-brew macos-iterm macos-sublime macos-terminal macos-vscode macos-xcode
	run "pkg/macos-app-dev/macos-app-dev.sh"

###############################################################################
# CLI Suite                                                                   #
###############################################################################

macos-cli-network: macos-brew
	run "pkg/cli-network/macos-cli-network.sh"

macos-cli-useful: macos-brew
	run "pkg/cli-useful/macos-cli-useful.sh"

###############################################################################
# Apps                                                                        #
###############################################################################

macos-alfred: macos-brew
	run "pkg/macos-alfred/macos-alfred.sh"

macos-appcleaner: macos-brew
	brew install --cask appcleaner
	defaults import net.freemacsoft.AppCleaner pkg/macos-appcleaner/net.freemacsoft.AppCleaner.plist

macos-cleanshot: macos-brew
	run "pkg/macos-cleanshot/macos-cleanshot.sh"

macos-dropbox: macos-brew
	run "pkg/dropbox/macos-dropbox.sh"

macos-finder:
	run "pkg/macos-finder/macos-finder.sh"

macos-hammerspoon: macos-brew macos-stow
	brew install --cask hammerspoon
	stow --no-folding --dir 'pkg' --target "${HOME}" 'macos-hammerspoon'

macos-iterm: macos-brew
	brew bundle --file pkg/macos-iterm/macos-iterm.Brewfile
	exists imgcat || (run "pkg/macos-iterm/macos-iterm.sh")

macos-markedit: macos-brew
	run "pkg/macos-markedit/macos-markedit.sh"

macos-one-password: macos-brew
	run "pkg/one-password/macos-one-password.sh"

macos-popclip: macos-brew
	run "pkg/macos-popclip/macos-popclip.sh"

macos-sublime: macos-brew macos-stow
	brew install --cask sublime-text
	run "pkg/sublime/macos-sublime.sh"

macos-terminal: macos-brew
	run "pkg/macos-terminal/macos-terminal.sh"

macos-tower: macos-brew macos-git
	brew install --cask tower
	run "pkg/macos-tower/macos-tower.sh"

macos-vscode: macos-brew
	brew install --cask visual-studio-code
	run "pkg/vscode/macos-vscode.sh"

macos-xcode: macos-brew
	run "pkg/macos-xcode/macos-xcode.sh"

###############################################################################
# CLIs                                                                        #
###############################################################################

macos-docker: macos-brew
	run "pkg/docker/macos-docker.sh"

macos-duti: macos-brew
	run "pkg/macos-duti/macos-duti.sh"

# This is a full suite of git plugins and configurations
# Most other target that requires git don't need this
macos-git: macos-brew
	run "pkg/git/macos-git.sh"

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
	${BREW_BIN}/brew bundle --file pkg/zsh/zsh.Brewfile
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
	run "pkg/macos-font/macos-font.sh"

macos-icon: macos-cli-useful
	run "scripts/macos-icons.sh"

macos-quicklook: macos-brew
	run "pkg/macos-quicklook/macos-quicklook.sh"

macos-screensaver: macos-brew
	run "pkg/macos-screensaver/macos-screensaver.sh"

macos-service-workflow: macos-stow
	stow --dir 'pkg' --target "${HOME}/Library/Services" 'macos-services'

macos-settings:
	run "scripts/macos-settings.sh"

macos-touch-id-sudo:
	run "scripts/macos-touch-id-sudo.sh"
