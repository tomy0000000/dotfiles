#!/usr/bin/env bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

function check_command {
	if ! command -v "${1}" &>/dev/null; then
		echo -e "${YELLOW}Command ${1} is not available, install now...${NC}"
		if [ "${1}" = 'sudo' ]; then
			apt-get install -qqq -y sudo >/dev/null
		else
			sudo apt-get install -qqq -y "${1}" >/dev/null
		fi
	fi
}

function create_user {
	useradd "${username}" --shell="/bin/bash" --groups="root,sudo" --home-dir="${HOME}"
	echo "${username}:${password}" | chpasswd
	echo "root:${password}" | chpasswd
	cp -r /etc/skel/. "${HOME}"
	chown "${username}:${username}" -R "${HOME}"
	echo "export PATH=\"${HOME}/.local/bin:"'${PATH}'"\"" >>"${HOME}/.bashrc"
	echo -e "User created: ${GREEN}${username}${NC}"
}

function setup_user {
	username="${username:-tomy0000000}"
	HOME="/home/${username}"
	if id "${username}" &>/dev/null; then
		echo -e "${YELLOW}User ${username} already exists, skip creation${NC}"
	else
		if [ -z "${password}" ]; then
			echo -e "${YELLOW}Password is not set, generate one${NC}"
			check_command 'openssl'
			password="$(openssl rand -base64 32)"
			create_user
			echo "${password}" >>"${HOME}/.password"
			echo -e "${RED}MAKE SURE TO SAVE AND REMOVE PASSWORD at ${YELLOW}${HOME}/.password${NC}"
		else
			create_user
		fi
	fi
}

if [ "$(uname)" = "Linux" ]; then
	distro=$(
		. /etc/os-release
		echo "${NAME}"
	)
	case "${distro}" in
	'Ubuntu')
		if [ "${EUID}" -eq 0 ]; then
			apt-get update -qq
			check_command 'sudo'
			setup_user
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
elif [ "$(uname)" = 'Darwin' ]; then
	# Install Xcode command line tools
	if [ ! -d "$(xcode-select -p)" ]; then
		sudo xcode-select --install
	fi
fi

git clone -q 'https://github.com/tomy0000000/dotfiles.git' "${HOME}/.dotfiles"
echo -e "dotfiles is ready to be installed at ${GREEN}${HOME}/.dotfiles${NC}"
