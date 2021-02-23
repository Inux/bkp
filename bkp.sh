#!/bin/sh

#rsync v3.1 or higher required & bash of course

DISKSTATION=/Volumes/diskstation/bkp

#directories to backup
directories=(
    '/Users/inux/Projects/'
    '/Users/inux/Documents/'
    '/Users/inux/Pictures/'
    '/Users/inux/Steuerfälle/'
    '/Users/inux/go/src/hoau/'
    '/Users/inux/go/src/steveineichenWeb/'
)

#do the actual bakup
doBackup () {
    echo $DISKSTATION' is available, starting bkp...'
    mkdir -p $DISKSTATION
    mkdir -p $DISKSTATION/Users
    mkdir -p $DISKSTATION/Users/inux
    for d in "${directories[@]}"
    do
        echo 'Backup: '$d
        rsync -z -r --rsh="ssh -c arcfour" --delete-after --whole-file --info=progress2 --exclude .git/ --exclude node_modules/ $d $DISKSTATION$d
    done
    echo $DISKSTATION' Done. Successful'
}

#copy files from home directory
mkdir -p /Users/inux/Projects/bkp/critical/home
cp ~/.bashrc /Users/inux/Projects/bkp/critical/home
cp ~/.bash_profile /Users/inux/Projects/bkp/critical/home
cp ~/.inuxenv /Users/inux/Projects/bkp/critical/home
cp ~/.inuxworkspaces /Users/inux/Projects/bkp/critical/home
cp ~/.zshrc /Users/inux/Projects/bkp/critical/home
cp ~/.zshrc.pre-oh-my-zsh /Users/inux/Projects/bkp/critical/home
cp ~/.config/karabiner/karabiner.json /Users/inux/Projects/bkp/critical/home/.config/karabiner/karabiner.json

rsync -avzr --delete-after --whole-file --info=progress2 ~/.oh-my-zsh /Users/inux/Projects/bkp/critical/home
rsync -avzr --delete-after --whole-file --info=progress2 ~/.ssh /Users/inux/Projects/bkp/critical/home

#check if backup is possible
if [ -d "$DISKSTATION" ]; then
    time doBackup
else
    echo $DISKSTATION' is not available. Nothing to do...'
fi
