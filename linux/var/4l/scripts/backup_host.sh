#!/bin/bash
# Description:
# Backup the root of the host to the $DEST.
# ~rusty
DEST="/media/luna/Babylon/archive/$HOSTNAME"
DATE=$(date +'%Y-%m-%d')
LOG="/var/log/4l/archive/$HOSTNAME/${DATE}.log"
cd "$DEST" || exit "$?"
tar -cvpzf "${HOSTNAME}.${DATE}.tar.gz" --one-file-system / 2&>1 >"$LOG"
if [[ "$?" != '0' ]];then
    echo "Oddity encountered during tar! Check $LOG"
fi
STALE=$(ls -r | tail -n +3) # Preserve only this and the last backup.
rm -f "$STALE" || exit "$?"