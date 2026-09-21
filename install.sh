#!/usr/bin/env bash
set -euo pipefail

# Logging helpers (inlined from lib/log.sh — lib/ is not available until after clone)
LOG_LEVEL=10   # DEBUG+
LOG_TIME=1
LOG_PREFIX="dotfiles-install"

_log_use_color() {
	[ -t 2 ] && [ -z "${NO_COLOR-}" ] && [ -n "${TERM-}" ] && [ "${TERM-}" != "dumb" ]
}

_log_fmt_prefix() {
	lvl="$1"
	if [ "${LOG_TIME}" = "1" ]; then
		ts="$(date '+%Y-%m-%d %H:%M:%S' 2>/dev/null || printf '%s' "")"
		if [ -n "$ts" ]; then
			printf '[%s] ' "$ts"
		fi
	fi
	printf '[%s]' "$lvl"
	if [ -n "${LOG_PREFIX}" ]; then
		printf ' [%s]' "${LOG_PREFIX}"
	fi
}

_log_print() {
	lvl="$1"
	shift
	case "${LOG_LEVEL}" in
		''|*[!0-9]*) min_level=20 ;;
		*)           min_level="${LOG_LEVEL}" ;;
	esac
	case "$lvl" in
		DEBUG)   lvl_num=10 ;;
		INFO)    lvl_num=20 ;;
		WARN)    lvl_num=30 ;;
		ERROR)   lvl_num=40 ;;
		*)       lvl_num=0  ;;
	esac
	[ "$lvl_num" -lt "$min_level" ] && return 0
	if _log_use_color; then
		case "$lvl" in
			DEBUG) c_start="$(printf '🐛 \033[36m')" ;;
			INFO)  c_start="$(printf 'ℹ️ \033[32m')" ;;
			WARN)  c_start="$(printf '⚠️ \033[33m')" ;;
			ERROR) c_start="$(printf '🛑 \033[31m')" ;;
			*)     c_start="" ;;
		esac
		c_end="$(printf '\033[0m')"
	else
		c_start=""
		c_end=""
	fi
	prefix="$(_log_fmt_prefix "$lvl")"
	if [ "$#" -gt 0 ]; then
		printf '%s%s %s%s\n' "$c_start" "$prefix" "$*" "$c_end" >&2
	else
		printf '%s%s%s\n' "$c_start" "$prefix" "$c_end" >&2
	fi
}

log_info()  { _log_print INFO  "$*"; }
log_warn()  { _log_print WARN  "$*"; }
log_error() { _log_print ERROR "$*"; }

# distro helper (inlined from lib/distro.sh — lib/ is not available until after clone)
distro() {
	case "$(uname)" in
		Linux)
			distro_name=$(
				# shellcheck source=/dev/null
				. /etc/os-release
				echo "${NAME}"
			)
			case $distro_name in
				"Ubuntu")       printf '%s' "ubuntu" ;;
				"Arch Linux")   printf '%s' "arch" ;;
				"CentOS Linux") printf '%s' "cent" ;;
				"Debian GNU/Linux") printf '%s' "debian" ;;
				"Fedora")       printf '%s' "fedora" ;;
				*)              printf '%s' "linux" ;;
			esac
			;;
		Darwin)
			printf '%s' "macos"
			;;
	esac
}

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
