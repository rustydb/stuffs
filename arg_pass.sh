#!/bin/bash

OPTION=$1
test -n "$OPTION" && shift
ANSIBLE_VARS=()
DIVIDER=""
for i in "$@"
do
    [ "$DIVIDER" == "1" ] && ANSIBLE_VARS+=("$i")

    [ "$i" == "--" ] && DIVIDER="1"
done
echo "$OPTION"
echo "${ANSIBLE_VARS[@]}"
