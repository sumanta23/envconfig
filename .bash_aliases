#!/usr/local/env bash

export EDITOR=vim
export SW_HOME=/opt/sw
#Set env variables
export JAVA_HOME=$SW_HOME/jdk1.7.0_75
export M2_HOME=$SW_HOME/apache-maven-3.3.3
export ANT_HOME=$SW_HOME/apache-ant-1.9.4
export GRADLE_HOME=$SW_HOME/gradle-2.3
export SUBLIME_HOME=$SW_HOME/sublime_test_3
PATH=$JAVA_HOME/bin:$M2_HOME/bin:$ANT_HOME/bin:$GRADLE_HOME/bin:$SUBLIME_HOME:$PATH

source /usr/share/git/git-prompt.sh

# install nvm in path
if [ -f ~/.nvm/nvm.sh ]; then
    . ~/.nvm/nvm.sh
fi


# Set Alias Commands
alias arq='mvn clean install -Pjboss_managed_local | tee /tmp/log.txt'
alias junit='mvn clean install | tee /tmp/log.txt'
alias findtxt='grep -rnw . -e'
alias gvim="gvim 2>/dev/null"

#battery Status
alias power='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | grep -oE "[0-9]{1,3}%"'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


#ctags generator
function createCtags(){
 ctags -R --languages=$1 --exclude=.git --exclude=logs --exclude=node_modules
}
alias ctag=createCtags


eval `dircolors ~/.vim/dircolors.256dark`
