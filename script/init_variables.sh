#!/bin/bash

ips=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"​`

for value in ${ips}
do
  if [[ "$value" =~ "10."* ]]
  then
    sed -i '/export IP4_HOST/d' ~/.profile
    echo "export IP4_HOST=$value  >> ~/.profile"
    echo "export IP4_HOST=$value" >> ~/.profile
    source ~/.profile
  fi
done
