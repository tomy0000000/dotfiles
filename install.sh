#!/usr/bin/env bash
set -euo pipefail

# Directory of this script (works even when called via symlink)
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

LOG_LEVEL=10   # DEBUG+
LOG_TIME=1
LOG_PREFIX="dotfiles-install"
LOG_COLOR=1
# shellcheck source=lib/log.sh
. "$SCRIPT_DIR/lib/log.sh"
# shellcheck source=lib/distro.sh
. "$SCRIPT_DIR/lib/distro.sh"

function ensure {
	if command -v "${1}" &>/dev/null; then
		return 0
	fi

	if [ "${1}" = 'sudo' ]; then
		apt-get install -qqq -y sudo >/dev/null
	else
		sudo apt-get install -qqq -y "${1}" >/dev/null
	fi

	log_info "${1} is installed"
}

function prepare_ubuntu {
	log_info "Preparing Ubuntu environment..."

	if [ "${EUID}" -eq 0 ]; then
		apt-get update -qq
		ensure 'sudo'
		log_warn "You are running as root!"
	else
		sudo apt-get update -qq
	fi

	# Install crucial commands
	ensure 'git'
	ensure 'make'
}

function prepare_macos {
	log_info "Preparing macOS environment..."

	# Check developer tools with git
	if git --version >/dev/null 2>&1; then
		return 0
	fi

	# Wait for developer tools to be installed
	log_info "Installing Developer tools..."
	xcode-select --install
	until git --version >/dev/null 2>&1; do
		sleep 5
		log_info "Waiting for developer tools to be installed..."
	done
}

function main {
	# Check existed clone
	if [ -d "${HOME}/.dotfiles" ]; then
		log_error "dotfiles already cloned at ${HOME}/.dotfiles"
		exit 1
	fi

	# Check OS
	case "$(distro)" in
	ubuntu)
		prepare_ubuntu
		;;
	macos)
		prepare_macos
		;;
	*)
		log_error 'Unsupported OS'
		exit 1
		;;
	esac

	# Clone dotfiles
	git clone -q 'https://github.com/tomy0000000/dotfiles.git' "${HOME}/.dotfiles"
	log_info "dotfiles is ready at ${HOME}/.dotfiles"
}

main "$@"
