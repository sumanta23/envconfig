#!/usr/bin/env bash

echo "install https://github.com/Anthony25/gnome-terminal-colors-solarized.git manually"

#create folders
mkdir -p ~/.m2 ~/.vim/.vimtemp/swaps ~/.vim/.vimtemp/backups ~/.vim/.vimtemp/undo

ln -s ~/.vim/.bashrc ~/.bashrc
ln -s ~/.vim/.bash_aliases ~/.bash_aliases
ln -s ~/.vim/.vimrc ~/.vimrc
ln -s ~/.vim/.gitconfig ~/.gitconfig
ln -s ~/.vim/.gitignore ~/.gitignore
ln -s ~/.vim/.screenrc ~/.screenrc
ln -s ~/.vim/.tmux.conf ~/.tmux.conf
ln -s ~/.vim/.gtkrc-2.0 ~/.gtkrc-2.0
ln -s ~/.vim/settings.xml ~/.m2/settings.xml
ln -s ~/.vim/pmdrules.xml ~/.m2/pmdrules.xml



#install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim


#install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


#install jedi-vim
#manually install "sudo pip install jedi"
cd ~/.vim/bundle/ && git clone --recursive https://github.com/davidhalter/jedi-vim.git

#install NERDTree
cd ~/.vim/bundle/ && git clone https://github.com/scrooloose/nerdtree.git

#install CTRLP
cd ~/.vim/bundle && git clone https://github.com/ctrlpvim/ctrlp.vim.git

#install vim-fugitive
cd ~/.vim/bundle && git clone https://github.com/tpope/vim-fugitive.git

#install syntastic
cd ~/.vim/bundle && git clone https://github.com/scrooloose/syntastic.git

#install supertab
cd ~/.vim/bundle && git clone https://github.com/ervandew/supertab.git

#install tabular
cd ~/.vim/bundle && git clone https://github.com/godlygeek/tabular.git

#install solarized
cd ~/.vim/bundle && git clone https://github.com/altercation/vim-colors-solarized.git

#install airline
cd ~/.vim/bundle && git clone https://github.com/bling/vim-airline.git
cd ~/.vim/bundle && git clone https://github.com/vim-airline/vim-airline-themes.git

#install surround
cd ~/.vim/bundle && git clone https://github.com/tpope/vim-surround.git

#install tagbar
cd ~/.vim/bundle && git clone https://github.com/majutsushi/tagbar.git

#install git-gutter
cd ~/.vim/bundle && git clone git://github.com/airblade/vim-gitgutter.git

#install ctrlp-funky
cd ~/.vim/bundle && git clone git://github.com/tacahiroy/ctrlp-funky.git

#install bufferstatus
cd ~/.vim/bundle && git clone https://github.com/bling/vim-bufferline.git

#install ctags
#sudo apt-get install ctags


vim +PluginInstall +qall
