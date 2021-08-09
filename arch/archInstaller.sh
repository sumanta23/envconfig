#!/bin/bash

hostname="basehost"
locale="en_US"
dev="/dev/sda"

pressanykey(){
	read -n1 -p "${txtpressanykey}"
}

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
    pressanykey
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
    pressanykey
    mkfs.ext4 "${dev}1"
    mkswap "${dev}2"
    pressanykey
}

mountdrive(){
    echo "mounting drives"
    mount /dev/sda1 /mnt
    swapon /dev/sda2
    pressanykey
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
    pressanykey
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
    pressanykey
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
    systemctl enable dhcpcd
}

grubinstall(){
    echo "installing grub"
    pacman -S grub
    grub-install /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg
}

tillchroot(){
    setntp
    chooseeditor
    diskpartition
    mountdrive
    syncmirror
    dopacstrap
    dogenfstab
    dochroot
}

postchroot(){
    settimezone
    localegen
    sethostname
    makeinitcpio
    setrootpasswd
    enabledhcp
    grubinstall
    unmountdrive
}
