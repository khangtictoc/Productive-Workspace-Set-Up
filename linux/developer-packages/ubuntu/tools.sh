## ENVIRONMENT VARIABLES ##
HELM_VERSION=v3.16.4
RUBY_VERSION=3.4.4

# General & Prerequisites
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

# Cloud
## AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
echo "==== CLEAN UP ===="
rm -f awscliv2.zip && rm -drf aws
## Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | bash 
## GCP
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
apt-get update && apt-get install google-cloud-cli



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
apt install -y chrony # NTP Client


# Programming Languages
## Ruby - Using rbenv. Reference: https://github.com/rbenv/rbenv?tab=readme-ov-file#basic-github-checkout
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
~/.rbenv/bin/rbenv init
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
git -C "$(rbenv root)"/plugins/ruby-build pull
apt-get install build-essential autoconf libssl-dev libyaml-dev zlib1g-dev libffi-dev libgmp-dev rustc
rbenv install ${RUBY_VERSION:-3.4.4} # Install Ruby version

# Blogging Jekyll
gem install bundler
bundle install
bundle exec jekyll serve

# Database Tools
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
apt install -y postgresql-client # Already include pgdump, pg_restore, psql, etc.
## MongoDB
### Tools
wget "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb"       
dpkg -i mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb
echo "==== CLEAN UP ===="
rm -f mongodb-database-tools-ubuntu2204-x86_64-100.12.2.deb
### MongoDB Shell
wget -qO- https://www.mongodb.org/static/pgp/server-8.0.asc |  tee /etc/apt/trusted.gpg.d/server-8.0.asc
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-8.0.list
apt-get update
apt-get install -y mongodb-mongosh

# Terminal & Linux system
## Monitoring
apt install -y iftop
apt install -y iotop
apt install -y atop
## sysz (Systemd service manager)
wget -O /usr/local/bin/sysz https://github.com/joehillen/sysz/releases/latest/download/sysz
chmod +x /usr/local/bin/sysz

# Container Environment
## Docker
# Add Docker's official GPG key:
apt-get update
apt-get install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
docker run hello-world

## Dive - Compare Docker image's difference
DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -OL https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb
apt install ./dive_${DIVE_VERSION}_linux_amd64.deb
echo "==== CLEAN UP ===="
rm -f dive_${DIVE_VERSION}_linux_amd64.deb

## Kubectl - Kubernetes CLI
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

## Node Shell
curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
chmod +x ./kubectl-node_shell
mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell

## K9S
wget https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.deb
apt install ./k9s_linux_amd64.deb
echo "==== CLEAN UP ===="
rm k9s_linux_amd64.deb

# Lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# Helm
curl -O https://get.helm.sh/helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz
tar -zxvf helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
echo "==== CLEAN UP ===="
rm -f helm-${HELM_VERSION:-v3.16.4}-linux-amd64.tar.gz



# VM images, Infrastructure & Configuration templating
## Terraform
wget https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_amd64.zip
unzip terraform_1.10.3_linux_amd64.zip
mv terraform /usr/local/bin/terraform
echo "==== CLEAN UP ===="
rm -f terraform_1.10.3_linux_amd64.zip

## Terragrunt
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.71.2-alpha2024122002/terragrunt_linux_amd64
chmod u+x terragrunt_linux_amd64
mv terragrunt_linux_amd64 /usr/local/bin/terragrunt


## Packer
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && apt-get install packer

## Vagrant
wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt update && apt install vagrant
vagrant plugin install vagrant-vmware-desktop # Optional

# SSL & Certificates
apt install -y certbot python3-certbot-nginx

# NPM Tools
npm install -g @jsware/jsonpath-cli # JSONPath query tool

