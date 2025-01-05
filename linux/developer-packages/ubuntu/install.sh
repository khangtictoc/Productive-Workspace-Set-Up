## ENVIRONMENT VARIABLES ##
set HELM_VERSION v3.16.4
HELM_VERSION=v3.16.4

## GENERAL ##
apt install -y unzip
# File editor
apt install -y vim
apt install -y nano
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
apt install -y rg # ripgrep - Search content in multiples files or folders
apt install -y bc # Convenient calculator
apt install -y jq # JSON Values Extractor

# Database
## MySQL
apt install -y mysql-client
## Redis
apt install -y nodejs
apt install -y npm
npm install -g redis-cli

# Container, Docker & Kubernetes
## Node Shell
curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
chmod +x ./kubectl-node_shell
sudo mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell

# Superfile - File Manager
bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"

# Helm
curl -O https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz
tar -zxvf helm-$HELM_VERSION-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm

# AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Terraform
wget https://releases.hashicorp.com/terraform/1.10.3/terraform_1.10.3_linux_amd64.zip
unzip terraform_1.10.3_linux_amd64.zip
sudo mv terraform /usr/local/bin/terraform

# Terragrunt
wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.71.2-alpha2024122002/terragrunt_linux_amd64
sudo chmod u+x terragrunt_linux_amd64
sudo mv terragrunt_linux_amd64 /usr/local/bin/terragrunt