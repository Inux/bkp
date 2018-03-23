#!/bin/sh

#rsync v3.1 or higher required & bash of course

DISKSTATION=/Volumes/diskstation/bkp/

#directories to backup
directories=(
    '/Users/inux/Projects/'
    '/Users/inux/Documents/'
)

#makes the actual bakup
doBackup () {
    echo $DISKSTATION' is available, starting bkp...'
    for d in "${directories[@]}"
    do
        echo 'Backup: '$d
        mkdir -p $DISKSTATION$d
        rsync -a --info=progress2 $d $DISKSTATION$d
    done
    echo $DISKSTATION' Done. Successful'
}

#check if backup is possible
if [ -d "$DISKSTATION" ]; then
    time doBackup
else 
    echo $DISKSTATION' is not available. Nothing to do...'
fi

