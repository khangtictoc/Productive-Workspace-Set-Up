#! /bin/bash

### REMOTE DESKTOP FOR LINUX UI

sudo apt update
sudo apt install xrdp -y
sudo systemctl status xrdp
sudo nano /etc/xrdp/xrdp.ini
sudo systemctl restart xrdp

sudo ufw status
sudo ufw enable
sudo ufw allow 49952/tcp
sudo ufw reload