#!/usr/bin/env bash

: <<'END_COMMENT'
This bash script loops over every users home directory and 
adds a new line to the users .bashrc. The first argument
when running this script is the content that will be put
in the .bashrc. For example:

./add_to_profiles.sh "export N_PREFIX=$HOME/.n"
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
  echo "Adding '$1' to $FOLDER..."
  echo -e "\n# Added using $SCRIPT\n$1" >> "$FOLDER/.bashrc"
done