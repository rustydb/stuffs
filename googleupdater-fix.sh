#!/bin/bash

# https://apple.stackexchange.com/questions/453027/how-can-i-stop-getting-google-updater-added-items-that-can-run-in-the-backgrou

rm -rf ~/Library/LaunchAgents/*google*
sudo rm -rf /Library/LaunchAgents/*google*
sudo rm -rf /Library/LaunchDaemons/*google*
