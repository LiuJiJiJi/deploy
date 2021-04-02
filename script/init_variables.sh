#!/bin/sh

ips=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"​`
echo "ip4: ${ips[0]}"
export IP4="${ips[0]}"
