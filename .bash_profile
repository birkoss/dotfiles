
# tmux quick alias
alias tmux-load="tmux a -t"
alias tmux-new="tmux new -s"

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

	# Get the ssh name in SSH config, if available
	custom_folder=$(grep -i "host $ssh_name" -m1 ~/.ssh/config)

	# If the ssh name is found in the SSH config
	if [[ $custom_folder != '' ]]; then
		# Create the folder (no error if existing)
		mkdir -p ~/Mounts/$ssh_name > /dev/null

		# If the SSH config file has a comment on the Host line
		if [[ $( echo $custom_folder | cut -d "#" -f2 ) != "Host $ssh_name" ]]; then
			mount_folder=$( echo $custom_folder | cut -d "#" -f2 )
		fi

		# If no mount folder is specified, use a default one
		if [[ $mount_folder == "" ]]; then
			mount_folder="public_html/"
		fi

		# If mount folder is empty
		if ! [[ $(ls ~/Mounts/$ssh_name) ]]; then
			sshfs $ssh_name:$mount_folder ~/Mounts/$ssh_name && echo "~/Mounts/$ssh_name:$mount_folder mounted!" || (sshfs $ssh_name: ~/Mounts/$ssh_name && echo "~/Mounts/$ssh_name mounted!")
		fi
		cd ~/Mounts/$ssh_name
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
			# Unmount
			[[ $(mount | grep "Mounts/$dir") ]] && fusermount -u ~/Mounts/$dir
			# Delete if empty
			[[ $(ls ~/Mounts/$dir) ]] || rm -d ~/Mounts/$dir
		done
	else
		# Unmount
		[[ $(mount | grep "Mounts/$1") ]] && fusermount -u ~/Mounts/$1	
		# Delete if empty
		[[ $(ls ~/Mounts/$1) ]] || rm -d ~/Mounts/$1
	fi
}

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.bash_profile_local ]; then
    . ~/.bash_profile_local
fi
