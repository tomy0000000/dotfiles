#!/bin/bash
set -euo pipefail

TouchIDStatus=$(bioutil -rs | grep unlock | awk '{print $4}')
if [[ "${TouchIDStatus}" = "1" ]]; then
	sudo sed -i '2 i auth sufficient pam_tid.so' /etc/pam.d/sudo
else
	echo "Touch ID unavailable, skip setting."
fi
