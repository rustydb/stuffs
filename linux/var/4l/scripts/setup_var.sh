#!/bin/bash

# Directories.
SCRIPTS=/var/4l/scripts
LOG=/var/log/4l

# Make folder(s).
MAIN_USER=rusty
groupadd admin
mkdir -p "$SCRIPTS" "$LOG"
chown -R "$MAIN_USER":admin "$SCRIPTS" "$LOG"

# Add local items to 4l area.
cp -p * "$SCRIPTS"
