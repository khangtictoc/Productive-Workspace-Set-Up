## ENVIRONMENT VARIABLES ##
#set HELM_VERSION v3.16.4
HELM_VERSION=v3.16.4

# General
apt install -y unzip
apt install -y python3-pip

# File Editor
apt install -y vim
apt install -y nano
# Superfile - File Manager
bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"

# VSystem's health & process
apt install -y pv # View process for MySQL restore database
apt install -y strace
apt install -y file
apt install -y htop
# Download URL
apt install -y wget
apt install -y curl
apt install -y dos2unix


# Network
apt install -y dnsutils
apt install -y net-tools
apt install -y iputils-ping
apt install -y telnet
apt install -y inetutils-traceroute
apt install -y nmap
apt install -y netcat
apt install -y whois
apt install -y mtr
curl -sS https://raw.githubusercontent.com/mr-karan/doggo/main/install.sh | sh

# Disk
apt install -y sysstat
apt install -y iotop

curl -sL https://aka.ms/InstallAzureCLIDeb | bash # az-cli


## Tools
apt install -y exiftool #Read metadata file
apt install -y ibus-unikey # # Type Vietnamese character
apt install -y git
apt install -y youtube-dl # Youtube downloader (video)
apt install -y bless #  Editor for bin files
apt install -y diodon # Save clipboard history
apt install -y neofetch # Show system in4 (pretty)
apt install -y htop # show process (pretty)
apt install -y tree
apt install -y lshw # Display hardware info
apt install -y tilix # Add multi-terminal in 1 display
apt install -y ripgrep # ripgrep - Search content in multiples files or folders
apt install -y bc # Convenient calculator
apt install -y jq # JSON Values Extractor

# Database
## MySQL
apt install -y mysql-client
## Redis
apt install -y nodejs
apt install -y npm
npm install -g redis-cli
## SQL Server
curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
source /etc/os-release
curl https://packages.microsoft.com/config/ubuntu/$VERSION_ID/prod.list | tee /etc/apt/sources.list.d/mssql-release.list
apt-get update
apt-get install mssql-tools18 unixodbc-dev
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bash_profile
source ~/.bash_profile
## Postgres
apt install -y postgresql-client

# Terminal & Linux system
## Monitoring
apt install -y iftop
apt install -y iotop
apt install -y atop
## sysz (Systemd service manager)
sudo wget -O /usr/local/bin/sysz https://github.com/joehillen/sysz/releases/latest/download/sysz
sudo chmod +x /usr/local/bin/sysz

# Container Environment
## Docker
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world

## Dive - Compare Docker image's difference
DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -OL https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb
sudo apt install ./dive_${DIVE_VERSION}_linux_amd64.deb
echo "==== CLEAN UP ===="
rm -f dive_${DIVE_VERSION}_linux_amd64.deb

## Kubectl - Kubernetes CLI
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

## Node Shell
curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
chmod +x ./kubectl-node_shell
sudo mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell

## K9S
wget https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb
sudo apt install ./k9s_linux_amd64.deb
echo "==== CLEAN UP ===="
rm k9s_linux_amd64.deb

# Lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Helm
curl -O https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz
tar -zxvf helm-$HELM_VERSION-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
echo "==== CLEAN UP ===="
rm -f helm-$HELM_VERSION-linux-amd64.tar.gz

# AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
echo "==== CLEAN UP ===="
rm -f awscliv2.zip && rm -drf aws

# VM images, Infrastructure & Configuration templating
## Terraform
wget https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_amd64.zip
unzip terraform_1.10.3_linux_amd64.zip
sudo mv terraform /usr/local/bin/terraform
echo "==== CLEAN UP ===="
rm -f terraform_1.10.3_linux_amd64.zip

## Terragrunt
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.71.2-alpha2024122002/terragrunt_linux_amd64
sudo chmod u+x terragrunt_linux_amd64
sudo mv terragrunt_linux_amd64 /usr/local/bin/terragrunt


## Packer
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install packer

## Vagrant
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant
vagrant plugin install vagrant-vmware-desktop # Optional

# SSL & Certificates
sudo apt install -y certbot python3-certbot-nginx