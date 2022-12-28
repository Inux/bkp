#!/bin/bash

HOME_TMP_BKP_DIR="/Users/inux/Projects/bkp/critical/home"
KEYCHAIN_TMP_BKP_DIR="/Users/inux/Projects/bkp/critical/keychain"

FINAL_BKP_DIR="/Users/inux/Library/Mobile Documents/com~apple~CloudDocs/Backup/inuxbook"
FINAL_BKP_OLD_DIR="/Users/inux/Library/Mobile Documents/com~apple~CloudDocs/Backup/old"

#copy files from home directory
rm -rf $HOME_TMP_BKP_DIR
mkdir -p $HOME_TMP_BKP_DIR
cp ~/.inuxenv $HOME_TMP_BKP_DIR
cp ~/.inuxworkspaces $HOME_TMP_BKP_DIR
cp ~/.zshrc $HOME_TMP_BKP_DIR
cp ~/.zshenv $HOME_TMP_BKP_DIR
cp -r ~/.oh-my-zsh $HOME_TMP_BKP_DIR
cp -r ~/.ssh $HOME_TMP_BKP_DIR

#copy files from keychain directory
rm -rf $KEYCHAIN_TMP_BKP_DIR
mkdir -p $KEYCHAIN_TMP_BKP_DIR
cp -r ~/Library/Keychains $KEYCHAIN_TMP_BKP_DIR

#move old backup to old directory
mkdir -p "$FINAL_BKP_DIR"
rm -rf "$FINAL_BKP_OLD_DIR"
mkdir -p "$FINAL_BKP_OLD_DIR"
mv "$FINAL_BKP_DIR" "$FINAL_BKP_OLD_DIR"

#create new backup of critical to iCloud
mkdir -p "$FINAL_BKP_DIR"
cp -r "$HOME_TMP_BKP_DIR" "$FINAL_BKP_DIR"
cp -r "$KEYCHAIN_TMP_BKP_DIR" "$FINAL_BKP_DIR"

echo "Backup finished."