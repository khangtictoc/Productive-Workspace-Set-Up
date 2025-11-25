#! /bin/bash

ssh <USER>@<HOSTNAME>
ssh -i <PRIVATE_KEY> <USER>@<HOSTNAME>

ssh-copy-id <USER>@<HOSTNAME>
ssh-copy-id -i <PRIVATE_KEY> <USER>@<HOSTNAME>