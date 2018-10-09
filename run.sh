#/bin/bash

# Some constants for use
COLOR_RED='\033[31m'
COLOR_GREEN='\033[32m'
COLOR_BG_GREEN='\033[42m'
COLOR_YELLOW='\033[33m'
COLOR_NORMAL='\033[0m'

# This file holds the references to usernames, hostnames, etc
source .secrets

HASSIO_USER=$SECRETS_HASSIO_USER
HASSIO_HOST=$SECRETS_HASSIO_HOST

DATE=`date +%Y-%m-%d`
HASSIO_BACKUP_DIR_PATH="$HOME/hassio.backups"
HASSIO_NEW_BACKUP_FOLDER_PREFIX="backup"
HASSIO_NEW_BACKUP_FOLDER_PATH=$HASSIO_BACKUP_DIR_PATH/$HASSIO_NEW_BACKUP_FOLDER_PREFIX-$DATE

# Check backups directory exists
if [ ! -d "$HASSIO_BACKUP_DIR_PATH" ]; then
  printf "${COLOR_YELLOW}Hassio backup dir not found, creating it...\n${COLOR_NORMAL}"
  mkdir $HASSIO_BACKUP_DIR_PATH
fi

# Check that an existing backup already doesn't already exist
if [ -d "$HASSIO_NEW_BACKUP_FOLDER_PATH" ]; then
  printf "${COLOR_YELLOW}Backup already found for today, exiting...\n${COLOR_NORMAL}"
  exit 1
fi

# Sync!
rsync -az $HASSIO_USER@$HASSIO_HOST:/config/ $HASSIO_NEW_BACKUP_FOLDER_PATH/

printf "${COLOR_GREEN}Backup finished :)\n${COLOR_NORMAL}"
