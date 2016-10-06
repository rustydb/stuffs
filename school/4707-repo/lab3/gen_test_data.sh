#!/bin/bash

for i in `seq 1 100`;
do
    sudo -u rusty installation/bin/psql -h localhost test1 -f lab3tests/buffertest1.sql | grep ":00.0*" >> data1.txt
    sudo -u rusty installation/bin/psql -h localhost test1 -f lab3tests/buffertest2.sql | grep ":00.0*" >> data2.txt
done
