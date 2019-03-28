#!/bin/bash
# Usage
# * * * * * ubuntu commands 2>&1 | logger -t "test.service"; ./bin/exit-check.sh ${PIPESTATUS[0]} test.service

RESULT=$1
SERVICE=$2
TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S"`

if [ $RESULT -gt 0 ]
then
    logger -p 'ERROR' -t "$2" "{\"ts\": \"$TIMESTAMP\", \"level\": \"ERROR\", \"message\": \"had a non zero exit: $1\"}"
else
    logger -p 'INFO' -t "$2" "{\"ts\": \"$TIMESTAMP\", \"level\": \"INFO\", \"message\": \"reported successful completion\"}"
fi