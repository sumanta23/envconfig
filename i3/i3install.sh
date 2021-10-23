#!/usr/bin/env bash




os=$(uname -s)
if [ $os == "Darwin" ]; then
    # do mac specific installtion stuff
else
    #create folders
    mkdir -p ~/.i3
    ln -s ${PWD}/i3config ~/.i3config
    cd ~/.i3
    git clone git://github.com/tobi-wan-kenobi/bumblebee-status
    cd -
    sudo pip install psutil netifaces
fi
