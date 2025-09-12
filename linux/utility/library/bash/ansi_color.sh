#! /bin/bash

function init-ansicolor() {
    # Foreground (text) colors
    BLACK='\033[0;30m'
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    BLUE='\033[0;34m'
    PURPLE='\033[0;35m'
    CYAN='\033[0;36m'
    WHITE='\033[0;37m'

    # Bold foreground colors
    BBLACK='\033[1;30m'
    BRED='\033[1;31m'
    BGREEN='\033[1;32m'
    BYELLOW='\033[1;33m'
    BBLUE='\033[1;34m'
    BPURPLE='\033[1;35m'
    BCYAN='\033[1;36m'
    BWHITE='\033[1;37m'

    # Background colors
    BG_BLACK='\033[40m'
    BG_RED='\033[41m'
    BG_GREEN='\033[42m'
    BG_YELLOW='\033[43m'
    BG_BLUE='\033[44m'
    BG_PURPLE='\033[45m'
    BG_CYAN='\033[46m'
    BG_WHITE='\033[47m'

    # Reset / No Color
    NC='\033[0m'
}
