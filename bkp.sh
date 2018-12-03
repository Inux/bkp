#!/bin/sh

#rsync v3.1 or higher required & bash of course

DISKSTATION=/Volumes/diskstation/bkp/

#directories to backup
directories=(
    '/Users/inux/Projects/'
    '/Users/inux/Documents/'
    '/Users/inux/Pictures/'
    '/Users/inux/Steuerfälle/'
    '/Users/inux/go/src/hoau/'
    '/Users/inux/go/src/steveineichenWeb/'
)

#copy some important files to bkp direcotry
cp ~/.bashrc /Users/inux/Projects/bkp/critical/
cp -r ~/.ssh /Users/inux/Projects/bkp/critical/

#do the actual bakup
doBackup () {
    echo $DISKSTATION' is available, starting bkp...'
    for d in "${directories[@]}"
    do
        echo 'Backup: '$d
        mkdir -p $DISKSTATION$d
        rsync -avzr --rsh="ssh -c arcfour" --delete-after --whole-file --info=progress2 --exclude .git/ --exclude node_modules/ $d $DISKSTATION$d
    done
    echo $DISKSTATION' Done. Successful'
}

#check if backup is possible
if [ -d "$DISKSTATION" ]; then
    time doBackup
else
    echo $DISKSTATION' is not available. Nothing to do...'
fi

