## NETWORK CARD INTERFACE
ip a show  eth0 | grep -oP "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}" | head -n1

## PORT
nmap -n -sP 192.168.21.0/24
nmap -p 1024-65534 192.168.20.225

# Show user, process name, port
ss -splunt 

## DNS
sudo systemd-resolve --flush-caches
# > Ubuntu 22.04
sudo resolvectl flush-caches

# dig
dig @8.8.8.8 <domain>
dig @1.1.1.1 <domain>


# SSL

## Check TLS supported on server
curl --tls-max 1.2 --tlsv1.2 <host>
curl -o /dev/null -s -w "%{http_code}" http://example.com
curl -o /dev/null -s -w "%{remote_ip}" http://example.com
