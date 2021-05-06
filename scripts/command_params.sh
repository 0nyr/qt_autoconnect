#!/bin/sh

# text formating
RESET="\e[0m"

BOLD="\e[1m"
DIM="\e[2m"
UNDERLINED="\e[4m"
BLINK="\e[5m"
REVERSE="\e[7m"

LIGHT_ORANGE_COLOR="\e[38;5;216m"
TURQUOISE_COLOR="\e[38;5;43m"
LIGHT_BLUE_COLOR="\e[38;5;153m"

PASSED_COLOR="\e[38;5;76m"
FAILED_COLOR="\e[38;5;197m"
MISSED_COLOR="\e[38;5;208m"

GREY1="\e[38;5;7m"
DESCRIPTION_FORMAT="\e[38;5;117m"



# [command flags]

# flags
verbose='false'

print_help() {
    echo "${DESCRIPTION_FORMAT}qt-autoconnect [FLAGS]
        Command to test connection and reconnect 
        to Quantic Telecom if necessary.

        -s          Ask to set user credentials
        --help      Print help for the command
        ${RESET}"
}

s_flah() {
    # check that the user wants to change credentials
    echo "${LIGHT_ORANGE_COLOR}*** Change user credentials ? [y/n] ***${RESET}"
    changing_credentials='n'
    read changing_credentials

    if [ $changing_credentials = 'y' ]; then
        ./get_credentials.sh
    fi
}

# [option: set user credentials]
while test $# -gt 0; do
    case "$1" in
        -s) 
            s_flah
            if [ $# -gt 0 ]; then shift; fi
            ;;
        -v) 
            last_argument=$1
            if [ $# -gt 0 ]; then shift; fi
            ;;
        --help) 
            print_help
            if [ $# -gt 0 ]; then shift; fi
            ;;
        *)
            echo "$1 is not a recognized flag!"
            return 1;
            ;;
    esac
done

exit 0
