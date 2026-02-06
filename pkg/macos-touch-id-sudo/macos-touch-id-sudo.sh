#!/bin/bash
set -euo pipefail

# Debug: Check bioutil command first
echo "Checking bioutil status..."
bioutil -rs || echo "bioutil command failed with exit code $?"

TouchIDStatus=$(bioutil -rs | grep unlock | awk '{print $4}')
echo "TouchID Status: $TouchIDStatus"

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


# #!/usr/bin/env bash
# set -e

# TouchIDStatus=$(bioutil -rs | grep unlock | awk '{print $4}')
# if [[ "${TouchIDStatus}" = "1" ]]; then
# 	sudo sed -i '2 i auth sufficient pam_tid.so' /etc/pam.d/sudo
# else
# 	echo "Touch ID unavailable, skip setting."
# fi