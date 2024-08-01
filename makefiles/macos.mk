macos-app-private: macos-brew macos-app-dev macos-one-password
	brew bundle --no-lock --file brewfiles/app-essential.Brewfile
	brew bundle --no-lock --file brewfiles/app-private.Brewfile
	brew bundle --no-lock --file brewfiles/app-social.Brewfile
	brew bundle --no-lock --file brewfiles/app-entertainment.Brewfile
	brew bundle --no-lock --file brewfiles/app-productivity.Brewfile
	brew bundle --no-lock --file brewfiles/app-utility.Brewfile
	brew bundle --no-lock --file brewfiles/app-design.Brewfile
	brew bundle --no-lock --file brewfiles/app-multimedia.Brewfile

macos-app-work: macos-brew macos-app-dev
	brew bundle --no-lock --file brewfiles/app-essential.Brewfile

macos-app-dev: macos-brew macos-iterm macos-xcode git
	brew bundle --no-lock --file brewfiles/app-dev.Brewfile

macos-brew:
	$(eval BREW_BIN := $(shell bin/brew_bin))
	exists brew || xscript "scripts/macos-brew.sh"
	${BREW_BIN}/brew tap homebrew/bundle
	${BREW_BIN}/brew bundle --no-lock --file brewfiles/core.Brewfile
	${BREW_BIN}/stow --no-folding --target "${HOME}" macos-brew

macos-chromium-app-icon: macos-brew
	exists fileicon || brew install fileicon
	xscript "scripts/macos-chromium-app-icon.sh"

macos-clean:
	find . -name ".DS_Store" -delete

macos-core: macos-brew macos-stow macos-zsh
	echo "🖥 Operating System: macOS"
	exists realpath || brew install coreutils

macos-cli-network: macos-brew
	brew bundle --no-lock --file brewfiles/cli-network.Brewfile

macos-docker: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/docker.Brewfile
	stow --no-folding --target "${HOME}" 'docker'

macos-finder:
	xscript "scripts/macos-finder.sh"

macos-font: macos-brew
	brew bundle --no-lock --file brewfiles/ext-font.Brewfile

# This is a full suite of git plugins and configurations
# Most other target that requires git don't need this
macos-git: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/git.Brewfile
	stow --no-folding --target "${HOME}" 'git'

macos-gnu-cli: macos-brew
	brew bundle --no-lock --file brewfiles/gnu-cli.Brewfile

macos-hammerspoon: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/hammerspoon.Brewfile
	stow --no-folding --target "${HOME}" 'hammerspoon'

macos-handful: macos-brew
	brew bundle --no-lock --file brewfiles/handful.Brewfile

macos-iterm: macos-brew
	brew bundle --no-lock --file brewfiles/iterm.Brewfile
	exists imgcat || xscript "scripts/macos-iterm.sh"

macos-micro: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/micro.Brewfile
	stow --no-folding --target "${HOME}" 'micro'

macos-nano: ;

macos-one-password: macos-brew macos-stow
	brew bundle --no-lock --file brewfiles/one-password.Brewfile
	stow --no-folding --target "${HOME}" 'macos-one-password'

macos-service-workflow: macos-stow
	stow --target "${HOME}/Library/Services" 'macos-services'

macos-shellcheck: macos-brew macos-stow
	exists shellcheck || brew install shellcheck
	stow --no-folding --target "${HOME}" 'shellcheck'

macos-stow: macos-brew macos-clean
	$(eval BREW_BIN := $(shell bin/brew_bin))
	exists stow || ${BREW_BIN}/brew install stow

macos-terminal: macos-brew
	brew bundle --no-lock --file brewfiles/terminal.Brewfile

macos-tower: macos-brew
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
