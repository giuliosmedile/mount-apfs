#!/bin/bash

# This tool will allow me to mount and unmount the macOS disk without any hassle
# Must be run with sudo privileges

set -e
COMMAND='apfs-fuse'				# The utility that must be installed to make this work
DRIVE='/dev/nvme0n1p2'			# Default drive location. Can be overridden following option -m

# Generic help function
help() { 
		printf "Tool to mount and unmount apfs drives. By default, selected drive to mount is \n\t\033[0;32m/dev/nvme0n1p2\n\n\033[0m"
		printf "Usage: $0 [-m <drive>] [-u]\n"
		exit 1
		}

# Checks if the program is ran as sudo
if [ "$EUID" -ne 0 ]
then
	printf "$0 must be run with sudo privileges.\n"
	help
	exit 1
fi

# Checks if apfs-fuse is installed in the system
if ! command -v $COMMAND &> /dev/null
then
    printf "$COMMAND must be installed for this program to function correctly.\n"
    help
fi

# Checks if at least one parameter is present
if (( $# <= 1 )) 
then
	help
fi

# Checks for option, either -m or -u
while getopts ":mu" arg; do
	case $arg in

		## CASE MOUNT
		m)
			if [ "${OPTARG}" -ne "" ]
			then
				DRIVE=${OPTARG}
			fi

			##
			printf "[-] Creating \033[0;32mmacos\033[0m folder...\n"
			errormessage=$( sudo mkdir -p /media/$USERNAME/macos )
			printf "$errormessage"
			
			printf "[-] Mounting drive...\n"
			errormessage=$( sudo $COMMAND -o allow_other $DRIVE /media/$USERNAME/macos )
			printf "$errormessage"
			
			printf "[-] Mounted drive succesfully."
			exit 0
			;;

		## CASE UNMOUNT
		u)
			
			##
			printf "[-] Unmounting disk...\n"
			errormessage=$( sudo fusermount -u /media/$USERNAME/macos )
			printf "$errormessage"
			printf "[-] Unmounted disk succesfully.\n"
			exit 0
			;;

		## HELP
		*)
			help
			;;
	esac
done