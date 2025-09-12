#! /bin/bash

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
echo "==== CLEAN UP ===="
rm -f awscliv2.zip && rm -drf aws