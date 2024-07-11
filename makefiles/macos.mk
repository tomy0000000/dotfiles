macos-brew:
	exists brew || xscript "scripts/macos-brew.sh"

macos-chromium-app-icon: macos-brew
	exists fileicon || brew install fileicon
	xscript "scripts/macos-chromium-app-icon.sh"

macos-clean:
	find . -name ".DS_Store" -delete

macos-core: macos-brew
	echo "🖥 Operating System: macOS"
	exists realpath || brew install coreutils

macos-cli-network: macos-brew
	brew bundle --no-lock --file 'brewfiles/cli-network.Brewfile'

macos-docker: macos-brew macos-stow
	brew bundle --no-lock --file 'brewfiles/docker.Brewfile'
	stow --no-folding --target "${HOME}" 'docker'

macos-font: macos-brew
	brew bundle --no-lock --file 'brewfiles/font.Brewfile'

# This is a full suite of git plugins and configurations
# Most other target that requires git don't need this
macos-git: macos-brew
	brew bundle --no-lock --file 'brewfiles/git.Brewfile'

macos-gnu-cli: macos-brew macos-stow
	brew bundle --no-lock --file 'brewfiles/gnu-cli.Brewfile'
	stow --no-folding --target "${HOME}" 'gnu-cli'

macos-handful: macos-brew
	brew bundle --no-lock --file 'brewfiles/handful.Brewfile'

macos-iterm: macos-brew
	brew bundle --no-lock --file 'brewfiles/iterm.Brewfile'
	xscript "scripts/macos-iterm.sh"

macos-micro: macos-brew macos-stow
	brew bundle --no-lock --file 'brewfiles/micro.Brewfile'
	stow --no-folding --target "${HOME}" 'micro'

macos-nano: ;

macos-one-password: macos-brew macos-stow
	brew bundle --no-lock --file 'brewfiles/one-password.Brewfile'
	stow --no-folding --target "${HOME}" 'macos-one-password'

macos-service-workflow: macos-stow
	stow --target "${HOME}/Library/Services" 'macos-services'

macos-shellcheck: macos-brew macos-stow
	exists shellcheck || brew install shellcheck
	stow --no-folding --target "${HOME}" 'shellcheck'

macos-stow: macos-brew macos-clean
	exists stow || brew install stow

macos-touch-id-sudo:
	xscript "scripts/macos-touch-id-sudo.sh"

macos-zsh: macos-brew macos-stow
	brew bundle --no-lock --file 'brewfiles/zsh.Brewfile'
	xscript "scripts/macos-zsh.sh"
