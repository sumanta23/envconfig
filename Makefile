.PHONY:bash git tmux vim ctags pbin ngrok

all: bash git tmux vim ctags pbin ngrok

bash:
	ln -s -f ${PWD}/bashconfig/bash_aliases ~/.bash_aliases

git:
	ln -s -f ${PWD}/git/gitconfig ~/.gitconfig
	ln -s -f ${PWD}/git/gitignore ~/.gitignore

tmux:
	ln -s -f ${PWD}/tmux/tmux.conf ~/.tmux.conf

vim:
	ln -s -f ${PWD}/vim/vimrc ~/.vimrc
	bash ${PWD}/vim/viminstall.sh

screen:
	ln -s -f ${PWD}/screen/screenrc ~/.screenrc

ctags:
	ln -s -f ${PWD}/lang/ctags ~/.ctags

pbin:
	ln -s ${PWD}/pbin ~/pbin

javaconfig:
	mkdir -p ~/.m2
	ln -s -f ${PWD}/lang/settings.xml ~/.m2/settings.xml
	ln -s -f ${PWD}/lang/pmdrules.xml ~/.m2/pmdrules.xml

xconfig:
	ln -s ${PWD}/linux/xinitrc ~/.xinitrc
	ln -s -f ${PWD}/linux/Xresources ~/.Xresources
	ln -s -f ${PWD}/linux/gtkrc-2.0 ~/.gtkrc-2.0


ngrok:
	curl -sO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip  | xargs unzip -d pbin/ -o ngrok-stable-linux-amd64.zip;rm ngrok-stable-linux-amd64.zip

