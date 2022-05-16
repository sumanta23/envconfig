#!/usr/bin/env bash


#install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/colors  ~/.vim/.vimtemp/swaps ~/.vim/.vimtemp/backups ~/.vim/.vimtemp/undo
curl -k -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cp monokai.vim ~/.vim/colors
#install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


#install ctags
#sudo apt-get install ctags

vim  +PluginInstall +qall
