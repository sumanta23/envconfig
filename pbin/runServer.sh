#!/usr/bin/env bash

function app () {
tmux new-session -s server -n App_Job -d 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

tmux split-window -h 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

appbase $1;
}

function wf () {
tmux new-window -a -n Service_Bots 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

tmux split-window -h 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

}


function alert () {
tmux new-window -a -n alerts 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

tmux split-window -h 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter
}

function appbase () {
tmux new-window -a -n Sand_WS 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

tmux split-window -h 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

tmux split-window -h 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

tmux selectp -t 1
tmux split-window -v 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

tmux selectp -t 0
tmux split-window -v 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter
}

function channel () {
tmux new-window -a -n Channels 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

tmux split-window -h 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

tmux selectp -t 1
tmux split-window -v 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

tmux selectp -t 0
tmux split-window -v 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter
}

function rtm(){
tmux new-window -a -n RTM 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter

tmux split-window -h 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter
}


function slack () {
tmux new-window -a -n slack 'cd ~/repo/myapp; bash -i;'
tmux send-keys 'node app.js' enter
}


################################

arg="app"
if [ $# -eq 1 ]
then
    arg=$1 
fi

case $arg in
    "app")
        app;
        wf;
        rtm;
        ;;
    "btw")
        app;
        wf;
        alert;
        ;;
    "all")
        app;
        wf;
        ;;
    "help")
        echo "runServer targets";
        ;;
    *) echo 'staring default'
        app;
        ;;
esac


################################


# runServer app wf auth rtm/email

tmux attach
