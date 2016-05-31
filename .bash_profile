# Remote Mount
###############################################################################
rmount() {
	# Local variable, should stay in this function
	local ssh_name mount_folder

	ssh_name="${1%%:*}"	# Get the first parameter until :	

	# If the first parameter is only the ssh name
	# - The mount folder is empty
	# - Else, use the remaining value after the :
	[[ ${1%:} == $ssh_name ]] && mount_folder='' || mount_folder=${1##*:}

	# If the ssh name is found in the SSH config
	if [[ $(grep -i "host $ssh_name" ~/.ssh/config) != '' ]]; then
		# Create the folder (no error if existing)
		mkdir -p ~/Mounts/$ssh_name > /dev/null

		# If no mount folder is specified, use a default one
		if [[ $mount_folder == "" ]]; then
			mount_folder="public_html/"
		fi

		sshfs $ssh_name:$mount_folder ~/Mounts/$ssh_name && echo "~/Mounts/$ssh_name:$mount_folder mounted!" || (sshfs $ssh_name: ~/Mounts/$ssh_name && echo "~/Mounts/$ssh_name mounted!")
	else
		echo "No entry found for $ssh_name"
		return 1
	fi
}

# Remove Unmount
###############################################################################
rumount() {
	# Unmount all folders
	if [[ $1 == "-a" ]]; then
		# Get all folders
		ls -1 ~/Mounts/|while read dir
		do
			[[ $(mount | grep "Mounts/$dir") ]] && fusermount -u ~/Mounts/$dir
		done
	else
		[[ $(mount | grep "Mounts/$1") ]] && fusermount -u ~/Mounts/$1	
	fi

	# To add and test...
	# [[ $(ls ~/Mounts/$1) ]] || rm -rf ~/Mounts/$1
}


# Remote Mount
###############################################################################
rmount() {
        # Local variable, should stay in this function
        local ssh_name mount_folder

        ssh_name="${1%%:*}"     # Get the first parameter until :       

        # If the first parameter is only the ssh name
        # - The mount folder is empty
        # - Else, use the remaining value after the :
        [[ ${1%:} == $ssh_name ]] && mount_folder='' || mount_folder=${1##*:}

        # If the ssh name is found in the SSH config
        if [[ $(grep -i "host $ssh_name" ~/.ssh/config) != '' ]]; then
                # Create the folder (no error if existing)
                mkdir -p ~/Mounts/$ssh_name > /dev/null

                # If no mount folder is specified, use a default one
                if [[ $mount_folder == "" ]]; then
                        mount_folder="public_html/"
                fi

                sshfs $ssh_name:$mount_folder ~/Mounts/$ssh_name && echo "~/Mounts/$ssh_name:$mount_folder mounted!" || (sshfs $ssh_name: ~/Mounts/$ssh_name && echo "~/Mounts/$ssh_name mounted!")
        else
                echo "No entry found for $ssh_name"
                return 1
        fi
}

# Remove Unmount
###############################################################################
rumount() {
        # Unmount all folders
        if [[ $1 == "-a" ]]; then
                # Get all folders
                ls -1 ~/Mounts/|while read dir
                do
                        [[ $(mount | grep "Mounts/$dir") ]] && fusermount -u ~/Mounts/$dir
                done
        else
                [[ $(mount | grep "Mounts/$1") ]] && fusermount -u ~/Mounts/$1
        fi
}


                # Get the default port from the ssh config
                # Set 22 as the default port if none is specified
#                mount_port=$(cat .ssh/config | sed -n "/Host $ssh_name/I,/^\$/p" | awk 'tolower($1) == "port" { print $2 }')
#                if [[ $mount_port == "" ]]; then
#                        mount_port="22"
#                fi

                # If no mount folder is specified...
                # Try to find one in the ssh config
#                if [[ $mount_folder == "" ]]; then
#                        mount_folder=$(cat .ssh/config | sed -n "/Host $ssh_name/I,/^\$/p" | awk 'tolower($1) == "folder" { print $2 }')
#                fi
