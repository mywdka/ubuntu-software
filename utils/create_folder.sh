#!/usr/bin/env bash

: <<'END_COMMENT'
This bash script loops over every users home directory and 
creates a new folder. The first argument when running this 
script is the name of the folder to be created in the home
directory. For example:

./create_folder.sh .config
./create_folder.sh MachineLearning/StyleGAN5
END_COMMENT

SCRIPT=`basename "$0"`

if [ -z "$1" ]; then
  echo "No argument given." >&2
  exit 1
fi

# Get all home folders
shopt -s nullglob
HOME_FOLDERS=(/home/*)
# Turn off nullglob to make sure it doesn't interfere with
# anything later
shopt -u nullglob

if (( ${#HOME_FOLDERS[@]} == 0 )); then
    echo "No subdirectories found" >&2
    exit 1
fi

for FOLDER in "${HOME_FOLDERS[@]}"
do
    # Strip user from home directory
    USER="${FOLDER##*/}"

    echo "Creating folder(s) '$1' in directory $FOLDER"
    mkdir -p "$FOLDER/$1"
    echo "Making sure $FOLDER is writable by $USER"
    chown -R $USER:$USER "$FOLDER/$1"
done