#!/bin/bash

setntp(){
   timedatectl set-ntp true
}

chooseeditor(){
	options=()
	options+=("nano" "")
	options+=("vim" "")
	options+=("vi" "")
	options+=("edit" "")
	sel=$(whiptail --backtitle "${apptitle}" --title "${txteditor}" --menu "" 0 0 0 \
		"${options[@]}" \
		3>&1 1>&2 2>&3)
	if [ "$?" = "0" ]; then
		clear
		echo "export EDITOR=${sel}"
		export EDITOR=${sel}
		EDITOR=${sel}
		pressanykey
	fi
}

rebootpc(){
	if (whiptail --backtitle "${apptitle}" --title "${txtreboot}" --yesno "${txtreboot} ?" --defaultno 0 0) then
		clear
		reboot
	fi
}

selectdisk(){
		items=$(lsblk -d -p -n -l -o NAME,SIZE -e 7,11)
		options=()
		IFS_ORIG=$IFS
		IFS=$'\n'
		for item in ${items}
		do  
				options+=("${item}" "")
		done
		IFS=$IFS_ORIG
		result=$(whiptail --backtitle "${APPTITLE}" --title "${1}" --menu "" 0 0 0 "${options[@]}" 3>&1 1>&2 2>&3)
		if [ "$?" != "0" ]
		then
				return 1
		fi
		echo ${result%%\ *}
		return 0    
}

diskpartition(){
    dev=$1 
    printf "o\nn\np\n1\n\n\nw\n" | sudo fdisk "$dev"
    //printf "n\np\n1\n+1G\nn\n2\n\n\nw\n" | sudo fdisk "$dev"
    sudo mkfs.ext4 "${dev}1"
}

setntp
chooseeditor
selectdisk