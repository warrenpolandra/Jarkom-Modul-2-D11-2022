#!/bin/bash

echo "
nameserver 192.168.122.1    # IP DNS
nameserver 192.190.2.2      # IP WISE | DNS MASTER
nameserver 192.190.3.2      # IP BERLINT | DNS SLAVE
" > /etc/resolv.conf

apt-get update
apt-get install dnsutils
apt-get install lynx -y
