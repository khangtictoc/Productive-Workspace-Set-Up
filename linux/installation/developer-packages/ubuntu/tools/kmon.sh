#! /bin/bash

wget https://github.com/orhun/kmon/releases/download/v1.7.1/kmon-1.7.1-x86_64-unknown-linux-gnu.tar.gz
tar -xzf kmon-1.7.1-x86_64-unknown-linux-gnu.tar.gz
sudo cp kmon-1.7.1/kmon /usr/local/bin/kmon
echo "==== CLEAN UP ===="
rm -f kmon-1.7.1-x86_64-unknown-linux-gnu.tar.gz
rm -drf kmon-1.7.1