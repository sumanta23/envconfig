#!/usr/local/env bash

export TERM=xterm-256color

export EDITOR=vim
export SW_HOME="$HOME/sw"
#Set env variables
export JAVA_HOME=$SW_HOME/jdk1.8.0_45
#export JAVA_HOME=$SW_HOME/jdk-9
export M2_HOME=$SW_HOME/apache-maven-3.3.3
export ANT_HOME=$SW_HOME/apache-ant-1.9.4
export GRADLE_HOME=$SW_HOME/gradle-2.3
export SUBLIME_HOME=$SW_HOME/sublime_test_3
PATH=$JAVA_HOME/bin:$M2_HOME/bin:$ANT_HOME/bin:$GRADLE_HOME/bin:$SUBLIME_HOME:$PATH

if [ -f /usr/share/git/git-prompt.sh ]; then
    source /usr/share/git/git-prompt.sh
fi

# install nvm in path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s $NVM_DIR/bash_completion ] && \. $NVM_DIR/bash_completion

alias ll='ls -alF'
alias g='git'
alias youtube='youtube-dl --extract-audio --audio-format mp3'

# Set Alias Commands
alias arq='mvn clean install -Pjboss_managed_local | tee /tmp/log.txt'
alias junit='mvn clean install | tee /tmp/log.txt'
alias findtxt='grep -rnw . -e'
alias j9='~/sw/jdk-9/bin/jshell'
alias gstd="git stash show -p"
alias gvim="gvim 2>/dev/null"
alias monitor='xrandr --output VGA1 --auto --right-of LVDS1'
alias primary='xrandr --output VGA1 --off'

#battery Status
alias power='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | grep -oE "[0-9]{1,3}%"'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#perftool
export SSLKEYLOGFILE=~/sslkeylog.log
alias tcpdump='sudo tcpdump -nni lo -vv -s0 -A'
alias perf='sudo perf record -F 99 -ag -- sleep 60'
alias perfr='sudo perf report --sort pid'
alias flame='sudo perf script | stackcollapse-perf.pl | flamegraph.pl'

#venv activate
alias venv='source .venv/bin/activate'

#ctags generator
function createCtags(){
    AG=`which ag`
    if [ ! -z $AG ]; then
        $AG -l | ctags -R --languages=$1 --exclude=.git --exclude=logs --exclude=node_modules
    else
        echo $AG + " File not found!"
        ctags -R --languages=$1 --exclude=.git --exclude=logs --exclude=node_modules
    fi
}
alias ctag=createCtags


function tubeplay() {
    #youtube-dl $1 -o - |  mplayer -vo aa -monitorpixelaspect 0.5 -
    mplayer <(youtube-dl -o - $1)
}

alias tubeplay=tubeplay

export PRIVATE_BIN=~/pbin
PATH=$PRIVATE_BIN:$PATH

eval `dircolors ~/envconfig/dircolors.256dark`


alias dnetps="docker ps -q | xargs docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias dstopall="docker ps -q | xargs docker stop"
alias drmall="docker ps -a -q | xargs docker rm"
alias drmstale="docker images |awk '{if(\$1=='<none>') print \$3}' | docker rmi"
