#!/bin/sh
echo "==================== start clean docker containers logs =========================="

logs=$(sudo find /var/lib/docker/containers/ -name *-json.log)

for log in $logs
    do
        echo "clean logs : $log"
        sudo cat /dev/null > $log
    done
echo "==================== end clean docker containers logs   =========================="