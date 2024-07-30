#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

function prompt_yes_no {
	read -r -p "${1} [y/N] " response
	case "${response}" in
	[yY][eE][sS] | [yY])
		true
		;;
	*)
		false
		;;
	esac
}

function check_command {
	if ! command -v "${1}" &>/dev/null; then
		echo "${YELLOW}Command ${1} is not available, install now...${NC}"
		if [ "${1}" = 'sudo' ]; then
			apt-get install -qqq -y sudo >/dev/null
		else
			sudo apt-get install -qqq -y "${1}" >/dev/null
		fi
	fi
}

function setup_user {
	# Prompt for username
	while true; do
		read -r -p 'Enter username: ' username
		if id "${username}" &>/dev/null; then
			echo "${RED}User ${username} already exists, please choose another one${NC}"
		else
			break
		fi
	done

	# Prompt for password
	while true; do
		read -r -p 'Enter password (leave blank to generate): ' password
		if [ -z "${password}" ]; then
			break
		else
			read -r -p 'Confirm password: ' confirm_password
			if [ "${password}" = "${confirm_password}" ]; then
				break
			else
				echo "${RED}Password does not match, please try again${NC}"
			fi
		fi
	done

	# Create user
	home="/home/${username}"
	useradd "${username}" --shell="/bin/bash" --groups="root,sudo" --home-dir="${home}"
	echo "${username}:${password}" | chpasswd
	echo "root:${password}" | chpasswd

	# Setup home directory
	cp -r /etc/skel/. "${home}"
	chown "${username}:${username}" -R "${home}"

	echo "export PATH=\"${home}/.local/bin:"'${PATH}'"\"" >>"${home}/.bashrc"
	echo "User created: ${GREEN}${username}${NC}"
	if [ -f "/root/.ssh/authorized_keys" ]; then
		mkdir -p "${home}/.ssh"
		cp "/root/.ssh/authorized_keys" "${home}/.ssh/authorized_keys"
		chown "${username}:${username}" "${home}/.ssh"
		chmod 700 "${home}/.ssh"
	else
		echo "${YELLOW}No authorized_keys for root${NC}"
		echo "${YELLOW}Make user to run 'make ubuntu-ssh' to setup SSH Key later${NC}"
	fi
}

function main {
	# Check OS
	OS=$(uname)
	case "${OS}" in
	Linux)
		distro=$(
			. /etc/os-release
			echo "${NAME}"
		)
		case "${distro}" in
		'Ubuntu')
			if [ "${EUID}" -eq 0 ]; then
				apt-get update -qq
				check_command 'sudo'
				echo "You are running as root."
				prompt_yes_no 'Do you want to create a new user?' && setup_user
			else
				sudo apt-get update -qq
			fi
			# Install crucial commands
			check_command 'git'
			check_command 'make'
			;;
		*)
			echo 'Unsupported distro'
			exit 1
			;;
		esac
		;;
	Darwin)
		# Check developer tools with git
		if ! git --version >/dev/null 2>&1; then
			echo "${YELLOW}Developer tools are not available, install now...${NC}"
			xcode-select --install
			# Wait for developer tools to be installed
			until git --version >/dev/null 2>&1; do
				sleep 1
				echo "${YELLOW}Waiting for developer tools to be installed...${NC}"
			done
		fi
		;;
	*)
		echo 'Unsupported OS'
		exit 1
		;;
	esac

	# Clone dotfiles
	git clone -q 'https://github.com/tomy0000000/dotfiles.git' "${HOME}/.dotfiles"
	echo "dotfiles is ready to be installed at ${GREEN}${HOME}/.dotfiles${NC}"
}

main
