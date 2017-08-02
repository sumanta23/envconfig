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
ln -s ${PWD}/gtkrc-2.0 ~/.gtkrc-2.0
ln -s ${PWD}/settings.xml ~/.m2/settings.xml
ln -s ${PWD}/pmdrules.xml ~/.m2/pmdrules.xml
ln -s ${PWD}/flat-theme ~/.themes/flat
ln -s ${PWD}/Xresources ~/.Xresources

#ln -s ${PWD}/xinitrc ~/.xinitrc
