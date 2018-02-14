#!/bin/bash

#ssh -L 4321:localhost:4321 -i private_key_path user@1stbox
#

MONGODUMP=`which mongodump`;
MONGORESTORE=`which mongorestore`;
MONGOCLIENT=`which mongo`

dbs=(test);
test=(accounts);

while [[ $# > 0 ]]
do
    key="$1"
    case $key in
        -h|--host)
            HOST="$2"
            shift
            ;;
        -p|--port)
            PORT="$2"
            shift
            ;;
        -r|--restore)
            RESTORE=YES
            ;;
        -a|--archive)
            ARCHIVE=YES
            ;;
        -d|--dropdbs)
            DROP=YES
            ;;
        --default)
            DEFAULT=YES
            ;;
        *)
            ;;
    esac
    shift 
done


if [ -z $HOST ] || [ -z $PORT ]; then
    echo " Execute script with proper --host and --port options";
    exit 1;
fi

if [ -z $MONGODUMP ] || [ -z $MONGORESTORE ]; then 
    echo "mongodump or mongorestore commands not in the path";
    exit 1;
else
    echo -e  "Found mongodump in \e[33m$MONGODUMP \e[0m\n";
    echo -e "Found mongorestore in \e[33m$MONGORESTORE \e[0m\n";
fi

create_folder(){
    FOLDERNAME=`pwd`/`date +"%h-%d-%Y-%H-%M-%S"`;
    mkdir $FOLDERNAME;
   
    if [ $? -ne 0 ]; then
        echo "Unable to create folder $FOLDERNAME";
        exit 1;
    fi
    
    echo -e "\nCreated folder $FOLDERNAME for backup\n";
}

backup_collection() {

    echo -e "Backing up \e[32m$2\e[0m";
    cd $FOLDERNAME;

    eval "mongodump --quiet --host $HOST --port $PORT --db=$1 --collection $2"
    if [ $? -ne 0 ]; then
        echo "Command $MONGODUMP exited with non zero response $?";
        exit 1;
    fi
}


archive_folder(){

    FILENAME=`basename $1`;
    echo -e "\n########### Archiving ########### \n";
    echo -e "Archiving contents of $1 to \e[32m$FILENAME.tgz\e[0m";
    cd $1;
    tar -zcf ../$FILENAME.tgz .
    if [ $? -ne 0 ]; then
        echo "Command tar exited with non zero response $?";
        exit 1;
    fi

    echo -e "\nDeleting folder \e[31m$1\e[0m";
    rm -rf $1;
}

create_folder;



echo -e "##### Initiating Backup ##### \n \n";
for db in ${dbs[@]} ; do
    for i in ${$db[@]} ; do 
        backup_collection $MDB $i ;
    done
done

for i in ${tBTCollections[@]} ; do 
    backup_collection $TDB $i ;
done



if [ "$ARCHIVE" == "YES" ]; then
    archive_folder $FOLDERNAME;
fi

echo -e "\nBye bye ...."
