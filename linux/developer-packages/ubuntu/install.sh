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

