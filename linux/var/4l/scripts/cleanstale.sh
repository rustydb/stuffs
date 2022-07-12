#!/bin/sh
# Description:
# Clean up /tmp. Useful if system is up for >2 weeks.
# ~rusty
set -e
# Cleanup /tmp however, do not remove sockets for X.
# NOTE: No lost+found with reiserfs
find /tmp/lost+found -exec /bin/touch {} \;
find /tmp -type s -exec /bin/touch {} \;
find /tmp -type d -empty -mtime +37 -exec /bin/rmdir {} \;
find /tmp -type f -mtime +37 -exec rm -rf {};
