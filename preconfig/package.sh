#!/bin/bash

# Function to check if a package is installed
package_installed() {
    dpkg -s $1 &> /dev/null
}

# Function to install packages on Ubuntu
install_ubuntu_packages() {
    sudo apt update
    sudo apt install -y ${@}
}

# Function to install packages on Arch Linux
install_arch_packages() {
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm ${@}
}

base="git curl make gcc vim tmux apache2-utils"
serverdebug="dnsutils iproute2 net-tools" #nslookup/dig ip/ss netstat
perf="linux-tools-common linux-tools-generic linux-tools-$(uname -r) sysstat"
arch_perf="linux-tools sysstat"

# List of packages to be installed
ubuntu_packages="$base $serverdebug $perf"
arch_packages="$base $serverdebug $arch_perf"


# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ $ID == "ubuntu" ]]; then
        echo "Detected Ubuntu"
        install_ubuntu_packages "$ubuntu_packages"
        echo "$package installed"
    elif [[ $ID == "arch" ]]; then
        echo "Detected Arch Linux"
        install_arch_packages "$arch_packages"
        echo "$package installed"
    else
        echo "Unsupported distribution"
        exit 1
    fi
else
    echo "Unsupported distribution"
    exit 1
fi

