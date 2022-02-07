#!/usr/bin/env bash

: <<'END_COMMENT'
This bash script finds all users and runs a command
based on the found user. The first argument when 
running this script is the command that will be run as
the user. Must be run as root. For example:

./run_as_user.sh 'echo "I am $USER, with uid $UID"'
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

for FOLDER in "${HOME_FOLDERS[@]}"
do
    # Strip user from home directory
    USER="${FOLDER##*/}"

    sudo -H -u "$USER" bash -c "$1"
done