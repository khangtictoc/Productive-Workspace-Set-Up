#! /bin/bash

wget https://nz2.archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl-dev_3.0.2-0ubuntu1.18_amd64.deb
sudo dpkg -i libssl-dev_3.0.2-0ubuntu1.18_amd64.deb
rm -f libssl-dev_3.0.2-0ubuntu1.18_amd64.deb