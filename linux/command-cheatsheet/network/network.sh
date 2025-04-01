## NETWORK CARD INTERFACE
ip a show  eth0 | grep -oP "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | head -n1

## PORT
nmap -n -sP 192.168.21.0/24
nmap -p 1024-65534 192.168.20.225
ss -nltp

## DNS
sudo systemd-resolve --flush-caches
# > Ubuntu 22.04
sudo resolvectl flush-caches

