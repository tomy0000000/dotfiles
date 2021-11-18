#!/usr/bin/env bash
set -e

TouchIDStatus=$(bioutil -rs | grep unlock | awk '{print $5}')
if [[ "${TouchIDStatus}" = "1" ]]; then
    sudo sed -i '2 i auth sufficient pam_tid.so' /etc/pam.d/sudo
else
    echo "Touch ID unavailable, skip setting."
fi
