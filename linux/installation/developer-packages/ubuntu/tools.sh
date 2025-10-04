## ENVIRONMENT VARIABLES ##

SHELLRC_FILE="$HOME/.zshrc"

# ┌──────────────────────────────────────┐
# │                                      │
# │    Prerequisites/Must-have Tools     │
# │                                      │
# └──────────────────────────────────────┘
sudo apt install -y unzip
sudo apt install -y python3-pip
sudo apt install -y linux-tools-generic # perf
sudo apt install -y tree
sudo apt install -y jq # JSON Values Extractor
sudo apt install -y chrony # NTP Client
sudo apt install -y wget
sudo apt install -y curl
sudo apt install -y dos2unix

# WSL
## Install WSL utilities - Open links in host browser, copy/paste between WSL and Windows, etc.
sudo add-apt-repository ppa:wslutilities/wslu
sudo apt update
sudo apt install -y wslu

# File Editor
sudo apt install -y vim
sudo apt install -y nano
## Superfile - File Manager
bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"

# Network
sudo apt install -y dnsutils
sudo apt install -y net-tools
sudo apt install -y iputils-ping
sudo apt install -y telnet
sudo apt install -y inetutils-traceroute
sudo apt install -y nmap
sudo apt install -y netcat
sudo apt install -y whois
sudo apt install -y mtr
curl -sS https://raw.githubusercontent.com/mr-karan/doggo/main/install.sh | sh
# ngrok
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/ngrok.sh | sh

# Disk
sudo apt install -y sysstat
sudo apt install -y iotop
sudo apt install -y ncdu # Treesizeview in Linux

# ┌────────────────────────────┐
# │                            │
# │      Productive Tools      │
# │                            │
# └────────────────────────────┘

sudo apt install -y exiftool #Read metadata file
sudo apt install -y ibus-unikey # # Type Vietnamese character
sudo apt install -y git
sudo apt install -y youtube-dl # Youtube downloader (video)
sudo apt install -y bless #  Editor for bin files
sudo apt install -y diodon # Save clipboard history
sudo apt install -y neofetch # Show system in4 (pretty)
sudo apt install -y htop # show process (pretty)
sudo apt install -y lshw # Display hardware info
sudo apt install -y tilix # Add multi-terminal in 1 display
sudo apt install -y ripgrep # ripgrep - Search content in multiples files or folders
sudo apt install -y bc # Convenient calculator
sudo apt-get purge lolcat -y
gem install lolcat # Require Ruby
npm install -g @jsware/jsonpath-cli # JSONPath query tool
# YAML Values Extractor
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/yq.sh | sudo sh
# jtbl - JSON Table
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/jtbl.sh | sudo sh

# ┌──────────────────────────────────────┐
# │                                      │
# │    Terminal, Linux system and TUI    │
# │                                      │
# └──────────────────────────────────────┘

# Monitoring
sudo apt install -y iftop
sudo apt install -y iotop
sudo apt install -y atop
## sysz (Systemd service manager)
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/sysz.sh | sh

# Network
## bandwhich
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/bandwhich.sh | sh
## speedtest - Ping latency
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
sudo apt-get install speedtest

# Kernal Modules
## kmon
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/kmon.sh | sh

# GPU
## nvtop - NVIDIA GPU process monitor
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/nvtop.sh | sh

# UFW
## tufw - TUI for UFW
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/tufw.sh | sh

# System's processes
sudo apt install -y pv # View process for MySQL restore database
sudo apt install -y strace
sudo apt install -y file
sudo apt install -y htop


# ┌────────────────────────────┐
# │                            │
# │       Cloud Platform       │
# │                            │
# └────────────────────────────┘
## AWS CLI
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/aws_cli.sh | sh

## Azure CLI
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/az_cli.sh | sh

## GCP
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/gcp_cli.sh | sh


# ┌────────────────────────────┐
# │                            │
# │   Programming Languages    │
# │                            │
# └────────────────────────────┘

## Ruby
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/ruby.sh | sh

## NodeJS
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/nodejs.sh | sh

## Go/Golang
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/go.sh | sh

# Blogging Jekyll
gem install bundler
bundle install
#bundle exec jekyll serve

# Database Tools
## MySQL
sudo apt install -y mysql-client
## Redis
sudo apt install -y nodejs
sudo apt install -y npm
npm install -g redis-cli
## SQL Server (MSSQL) CLI
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/sqlcmd.sh | sh

## Postgres
sudo apt install -y postgresql-client # Already include pgdump, pg_restore, psql, etc.
## MongoDB
### Tools & Shell
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/mongodb_cli.sh | sh

# ┌────────────────────────────┐
# │                            │
# │      DevOps Tools          │
# │                            │
# └────────────────────────────┘

# ---- CONTAINER ----
## Docker
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/docker.sh | sh

## Dive - Compare Docker image's difference
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/dive.sh | sh

## Kubectl - Kubernetes CLI
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/kubectl.sh | sh

## K9S
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/k9s.sh | sh

## Lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

## Helm
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/helm.sh | sh

## Kustomize
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash

## Argo CLI
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/argocd_cli.sh | sh

# ---- INFRA-AS-CODE (IAC) ----
## Terraform
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/terraform.sh | sh

## Terragrunt
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/terragrunt.sh | sh

## Packer
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/packer.sh | sh

## Vagrant & Plugins
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/vagrant.sh | sh

# ---- GIT ----
## git filter-repo 
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/git_filter_repo.sh | sh
## glab - GitLab CLI
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/glab.sh | sh

# ---- SECRET MANAGER ----
## HCP Vault
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/hcp_vault.sh | sh

# ---- TLS/SSL ----
## Certbot(Let's Encrypt)
sudo apt install -y certbot python3-certbot-nginx


# ┌────────────────────────────┐
# │                            │
# │       Security Tools       │
# │                            │
# └────────────────────────────┘

# ---- SCAN SECRETS ----

## GGShield
pip install --user ggshield
pip install --user --upgrade ggshield

## TruffleHog
curl -sSfL https://raw.githubusercontent.com/trufflesecurity/trufflehog/main/scripts/install.sh | sudo sh -s -- -b /usr/local/bin

## detect-secrets
curl -sS https://raw.githubusercontent.com/khangtictoc/Productive-Workspace-Set-Up/refs/heads/main/linux/installation/developer-packages/ubuntu/tools/detect_secrets.sh | sh

# ---- VULNERABILITY SCANNER ----

## Grype - Work with Syft (SBOM tool)
curl -sSfL https://get.anchore.io/grype | sudo sh -s -- -b /usr/local/bin

# ┌────────────────────────────┐
# │                            │
# │     Software Billings      │
# │                            │
# └────────────────────────────┘

# ---- SBOM TOOLS ----
## Syft
curl -sSfL https://get.anchore.io/syft | sudo sh -s -- -b /usr/local/bin

