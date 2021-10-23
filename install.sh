#!/usr/bin/env bash


#create folders
mkdir -p ~/.m2

ln -s -f ${PWD}/bashconfig/bashrc ~/.bashrc
ln -s -f ${PWD}/bashconfig/bash_aliases ~/.bash_aliases
ln -s -f ${PWD}/vim/vimrc ~/.vimrc
ln -s -f ${PWD}/git/gitconfig ~/.gitconfig
ln -s -f ${PWD}/git/gitignore ~/.gitignore
ln -s -f ${PWD}/screen/screenrc ~/.screenrc
ln -s -f ${PWD}/tmux/tmux.conf ~/.tmux.conf
ln -s -f ${PWD}/lang/settings.xml ~/.m2/settings.xml
ln -s -f ${PWD}/lang/pmdrules.xml ~/.m2/pmdrules.xml

ln -s ${PWD}/pbin ~/pbin



os=$(uname -s)
if [ $os == "Darwin" ]; then
	echo do mac specific installtion stuff
else
	mkdir -p ~/.themes
	ln -s ${PWD}/linux/xinitrc ~/.xinitrc
	ln -s ${PWD}/flat-theme ~/.themes/flat
	ln -s -f ${PWD}/linux/Xresources ~/.Xresources
	ln -s -f ${PWD}/linux/gtkrc-2.0 ~/.gtkrc-2.0
fi

echo "installing ngrok..."
cd ${PWD}/pbin/
curl -sO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip  | xargs unzip -o ngrok-stable-linux-amd64.zip;rm ngrok-stable-linux-amd64.zip
cd -
