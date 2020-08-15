#!/bin/bash

# This script create an new user on local system.

# Make sure the script being executed with root.
if [[ $UID -ne 0 ]]
then
	echo "Login as root or use sudo!"
	exit 1
fi

# Get the username.(login)
read -p "Enter username: " USER_NAME

# Get the real name (contens for the description field).
read -p "Enter real name: " COMMENT

# Get the password.
read -p "Enter password: " PASSWORD

# Create the account.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
	echo "Invalid username!"
	exit 1
fi

# Set password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
	echo "Invalid password!"
	exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display username, password, and host where the suer was created.
echo
echo "Username: "
echo ${USER_NAME}
echo
echo "Password: "
echo ${PASSWORD}
echo
echo "Host: "
echo $(hostname)
exit 0
