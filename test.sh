#!/bin/bash

#* * * * * vagrant /home/vagrant/test.sh 2>&1 | logger -t "test.epg"

TIMESTAMP=`date "+%Y-%m-%d %H:%M:%S"`

echo "{\"ts\": \"$TIMESTAMP\", \"level\": \"INFO\", \"message\": \"Validating you are the correct user\"}"
if [ "$(whoami)" != "vagrant" ]; then
        echo "{\"ts\": \"$TIMESTAMP\", \"level\": \"ERROR\", \"message\": \"Script must be run as user: vagrant\"}"
        echo "{\"ts\": \"$TIMESTAMP\", \"level\": \"ERROR\", \"message\": \"You are: $(whoami)\"}"
        exit -1
fi

echo "{\"ts\": \"$TIMESTAMP\", \"level\": \"INFO\", \"message\": \"Time to generate some garbage logs\"}"

for logline in {1..50}; do
    echo "{\"ts\": \"$TIMESTAMP\", \"level\": \"INFO\", \"message\": \"Garbage $logline\"}"
done