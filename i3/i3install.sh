#!/usr/bin/env bash




    #create folders
    mkdir -p ~/.i3
    ln -s ${PWD}/i3config ~/.i3config
    cd ~/.i3
    git clone git://github.com/tobi-wan-kenobi/bumblebee-status
    cd -
    sudo pip3 install psutil netifaces
