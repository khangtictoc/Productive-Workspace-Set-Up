#! /bin/bash

sudo apt install resolvconf -y
echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolvconf/resolv.conf.d/tail
