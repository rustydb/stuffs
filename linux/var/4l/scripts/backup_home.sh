#!/bin/bash
# Description:
# Backup the my home directory to the $DEST.
# ~rusty
DEST="/media/luna/Babylon/archive/home"
DATE=$(date +'%Y-%m-%d')
LOG="/var/log/4l/archive/home/${DATE}.log"
cd "$DEST" || exit "$?"
tar -cvpzf "home.${DATE}.tar.gz" --exclude-from="$PWD/exclude.txt" --one-file-system "$HOME"  2&>1 >"$LOG"
if [[ "$?" != '0' ]];then
    echo "Oddity encountered during tar! Check $LOG"
fi
STALE=$(ls -r | tail -n +3) # Preserve only this and the last backup.
rm -f "$STALE" || exit "$?"
