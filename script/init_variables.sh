#!/bin/sh

ips=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"​`

for value in ${ips}
do
  if [[ "$value" =~ "10."* ]]
  then
    echo "ip4: $value"
    export IP4="$value"
  fi
done

