#!/usr/bin/env bash


#create folders
mkdir -p ~/.m2

ln -s ${PWD}/bashrc ~/.bashrc
ln -s ${PWD}/bash_aliases ~/.bash_aliases
ln -s ${PWD}/vimrc ~/.vimrc
ln -s ${PWD}/gitconfig ~/.gitconfig
ln -s ${PWD}/gitignore ~/.gitignore
ln -s ${PWD}/screenrc ~/.screenrc
ln -s ${PWD}/tmux.conf ~/.tmux.conf
ln -s ${PWD}/settings.xml ~/.m2/settings.xml
ln -s ${PWD}/pmdrules.xml ~/.m2/pmdrules.xml

ln -s ${PWD}/pbin ~/pbin



os=$(uname -s)
if [ $os == "Darwin" ]; then
    # do mac specific installtion stuff
else
    mkdir -p ~/.themes
    ln -s ${PWD}/xinitrc ~/.xinitrc
    ln -s ${PWD}/flat-theme ~/.themes/flat
    ln -s ${PWD}/Xresources ~/.Xresources
    ln -s ${PWD}/gtkrc-2.0 ~/.gtkrc-2.0
fi

echo "installing ngrok..."
cd ${PWD}/pbin/
curl -sO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip  | xargs unzip -o ngrok-stable-linux-amd64.zip;rm ngrok-stable-linux-amd64.zip
cd -
