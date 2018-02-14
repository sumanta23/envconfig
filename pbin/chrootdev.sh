#!/bin/bash

# create dev root dir

BASEDIR=/tmp/mydev

xbinary(){
    regex='[\/][a-zA-z0-9-.\/]*'
    folderregex='[\/][a-zA-z0-9-.\/]*/'
    array=( $(ldd $1 | grep -oP "$regex") )
    folderPath=( $(ldd $1 | grep -oP "$folderregex"))
   

    for i in "${folderPath[@]}"
    do
         mkdir -p "$BASEDIR$i"
    done


    for j in "${array[@]}"
    do
         cp $j "$BASEDIR$j"
         echo $j
    done

    cp $1 "$BASEDIR$1"

}


mkdir -p $BASEDIR
cd $BASEDIR
mkdir -p {bin,lib,lib64,usr/bin}

BASHPATH=`which bash`
xbinary $BASHPATH

LSPATH=`which ls`
xbinary $LSPATH

DATEPATH=`which date`
xbinary $DATEPATH

TREEPATH=`which tree`
xbinary $TREEPATH

PSPATH=`which ps`
xbinary $PSPATH
