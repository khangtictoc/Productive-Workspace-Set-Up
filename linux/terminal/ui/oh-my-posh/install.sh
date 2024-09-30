####### Run for BASH only ######

sudo apt install -y unzip curl
curl -s https://ohmyposh.dev/install.sh | bash -s

#### To list all available fonts
# oh-my-posh font install
# oh-my-posh font install <font-name>

#### If command is not executable
BINARY_PATH="/usr/local/bin/"
if ! command -v oh-my-posh &> /dev/null
then
    echo "Command has not been executable, copy to $BINARY_PATH"
    sudo cp ~/.local/bin/oh-my-posh $BINARY_PATH
else
    echo "Command has install successfully!"
fi

