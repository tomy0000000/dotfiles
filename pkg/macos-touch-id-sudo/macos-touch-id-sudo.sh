#!/bin/bash
set -euo pipefail

# Check if Touch ID is available
if ! TouchIDStatus=$(bioutil -rs 2>/dev/null | grep unlock | awk '{print $4}'); then
	echo "Touch ID unavailable, skip setting."
	exit 0
fi

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
