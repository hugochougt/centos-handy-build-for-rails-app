#!/bin/sh

read -p 'Enter your new username: ' USER

adduser ${USER}
echo 'Added new system user: ${USER}'

echo 'Set password for ${UESR}'
passwd ${USER}

echo '${USER} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
echo 'Granted root privileges to ${UESR} user'

echo 'New user config done'
echo 'Please exit root user and login with ${USER} to continue'
