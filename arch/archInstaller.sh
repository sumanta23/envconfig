#!/bin/bash

hostname="basehost"
locale="en_US"
dev="/dev/sda"

setntp(){
   echo "setting ntp"
   timedatectl set-ntp true
}

chooseeditor(){
    echo "setting editor"
    echo "export EDITOR=vim"
    export EDITOR=vim
    EDITOR=vim
}

syncmirror(){
    echo "syncing  mirror"
    pacman -Syy
}

rebootpc(){
	if (whiptail --backtitle "${apptitle}" --title "${txtreboot}" --yesno "${txtreboot} ?" --defaultno 0 0) then
		clear
		reboot
	fi
}


diskpartition(){
    dd if=/dev/zero of=$dev bs=512 count=1 conv=notrunc
    sectors=$(sfdisk -s "$dev")
    totalsector=$((sectors * 2))
    swapsize=2095104
    primary=$((totalsector - swapsize - 2048))
    swapstart=$((primary + 2048))
    echo $totalsector $swapsize $primary

    

    cat <<EOF >>partition
    label: dos
    label-id: 0xd9c2d64f
    unit: sectors
    sector-size: 512

    /dev/sda1 : start= 2048, size= $primary, type=83
    /dev/sda2 : start= $swapstart, size= $swapsize, type=82
EOF

    sfdisk "$dev" < partition
    mkfs.ext4 "${dev}1"
    mkswap "${dev}2"
}

mountdrive(){
    echo "mounting drives"
    mount /dev/sda1 /mnt
    swapon /dev/sda2
}

unmountdrive(){
    echo "unmounting drive"
    umount -R /mnt
}

dopacstrap(){
    echo "pacstrap /mnt base linux linux-firmware vim dhcp"
    pacstrap /mnt base linux linux-firmware vim dhcp
}

dogenfstab(){
    echo "genfstab"
    genfstab -U /mnt >> /mnt/etc/fstab
}

dochroot(){
    echo "chrooting /mnt"
    arch-chroot /mnt
}

settimezone(){
    echo "setting timezone"
    ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
    hwclock --systohc
}

localegen(){
    echo "generating lacale"
    sed -i '/#'${locale}'.UTF-8/s/^#//g' /etc/locale.gen
    echo "LANG=${locale}.UTF-8" > /etc/locale.conf
    locale-gen
}

sethostname(){
    echo "setting hostname"
    echo "${hostname}" > /etc/hostname
}

makeinitcpio(){
    echo "mkinitcpio -P"
    mkinitcpio -P
}

setrootpasswd(){
    echo "setting root passwd"
    passwd root
}

enabledhcp(){
    pacman -Sy dhcp
    systemctl enable dhcpcd
}

grubinstall(){
    echo "installing grub"
    pacman -Sy grub
    grub-install /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg
}

archchrootrun(){
	cp ${0} /mnt/root/
	chmod 755 /mnt/root/$(basename "${0}")
	arch-chroot /mnt /root/$(basename "${0}") ${1}
	rm /mnt/root/$(basename "${0}")
	echo "exit"
}

configurepartition(){
    setntp
    chooseeditor
    diskpartition
    mountdrive
}

installsystem(){
    syncmirror
    dopacstrap
    dogenfstab
    #dochroot
}

configuresystem(){
    archchrootrun settimezone
    archchrootrun localegen
    archchrootrun sethostname
    archchrootrun makeinitcpio
    archchrootrun setrootpasswd
    archchrootrun enabledhcp
    archchrootrun grubinstall
    unmountdrive
}

main(){
    event=$1
    $1
}

main $1