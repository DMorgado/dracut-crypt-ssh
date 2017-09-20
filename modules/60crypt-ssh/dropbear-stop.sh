#!/bin/sh

[ -f /tmp/dropbear.pid ] || exit 0
read main_pid < /tmp/dropbear.pid
kill -STOP ${main_pid} 2>/dev/null
pkill -P ${main_pid}
kill ${main_pid} 2>/dev/null
kill -CONT ${main_pid} 2>/dev/null

# Flush all IP Configuration on all Interfaces 
# so not to interfere with NetworkManager
for i in $(ls /sys/class/net/) ; do
    /usr/sbin/ip addr flush $i &
done
