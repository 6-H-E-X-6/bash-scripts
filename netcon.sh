#!/bin/bash

# Used to confirm whether or not the user has confirmed to
# connect to their network of choice
confirm='n'

printf "Scanning for networks..."

# Assigns the list of networks to an array
readarray -t networks < <(nmcli -t -f BSSID dev wifi list)

# The length of the array
len=${#networks[@]}

# If the array is empty...
if [ $len -eq 0 ]; then
	
	#Exit the program
	printf '\n'
	printf "No networks found."
	exit;
fi

printf '\n'

# List available networks
nmcli dev wifi list | nl -v0

printf '\n'

# While the user's choice isn't confirmed...
while [ $confirm != y ]
do
	# Ask for a selection
	printf 'Please select a network using the number keys...\n'

	#Receive input
	read target

	# While the selection is out of range...
	while [ $target -gt $len ] || [ $target -eq 0 ] 
	do
		# Request valid input
		printf '\033[0;31mInvalid input, try again or press CTRL+C to exit.\033[0m\n'
		read target
	done

	# Convert user input into an array index
	target=$(($target - 1))

	printf 'Selected network: \033[0;32m%s\n \033[0mis this correct? (y/n)' "${networks[target]//\\/}"

	# Ask for confirmation. Repeats if input is anything but y
	read confirm

done

# Connect to the network with a password prompt
nmcli -a dev wifi connect ${networks[target]//\\/}
