#!/bin/bash
set -euo pipefail

TouchIDStatus=$(bioutil -rs | grep unlock | awk '{print $4}')
if [[ "${TouchIDStatus}" != "1" ]]; then
	echo "Touch ID unavailable, skip setting."
	exit 0
fi

# Check if Touch ID auth is already configured
if ! grep -q "auth.*sufficient.*pam_tid.so" /etc/pam.d/sudo; then
	sudo sed -i '' '2 i\
auth       sufficient     pam_tid.so' /etc/pam.d/sudo
	echo "Touch ID authentication enabled for sudo."
else
	echo "Touch ID authentication already configured for sudo."
fi
