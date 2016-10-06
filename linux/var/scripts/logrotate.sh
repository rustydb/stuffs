#!/bin/bash

log_dir="/var/log/backup"
cd $log_dir
home_daily=$(ls -r home.daily* | tail -n +5)
rusty_daily=$(ls -r rusty.daily* | tail -n +5)
home_weekly=$(ls -r home.weekly* | tail -n +5)
root_monthly=$(ls -r fruitloop* | tail -n +5)
vms_weekly=$(ls -r vmHDD* | tail -n +5)

rm -f $home_daily $rusty_daily $home_weekly $root_monthly $vms_weekly
