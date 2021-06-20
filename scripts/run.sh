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
GREY2="\e[38;5;248m"
GREY3="\e[38;5;243m"
DESCRIPTION_FORMAT="\e[38;5;117m"



# [command flags]
# variables and parameters
TEST_SCRIPTS_DIR=.
TEST_SRC_DIR=../src
SCRIPTS_DIR=/opt/qt_autoconnect/scripts
SRC_DIR=/opt/qt_autoconnect/scripts
execute_location=$SCRIPTS_DIR
execute="true"
debug="false"

# flag functions
t_flag() {
    execute_location=$TEST_SRC_DIR
    debug="true"
}

h_flag() {
    execute="false"
    echo "${TURQUOISE_COLOR}*** qt-autoconnect help ***${RESET}"
    echo "${DESCRIPTION_FORMAT}qt-autoconnect [FLAGS]
        Command to test connection and reconnect 
        to Quantic Telecom if necessary.

        --set, -s       Set user credentials
        --display, -d   Display currently registered user credentials 
        --help, -h      Print help for the command
        --credits, -c   Print developer credits

        --test, -t       Dev command for testing and debugging
        ${RESET}"
}

s_flag() {
    execute="false"
    # check that the user wants to change credentials
    echo "${LIGHT_ORANGE_COLOR}*** Change user credentials ? [y/n] ***${RESET}"
    changing_credentials='n'
    read changing_credentials

    if [ $changing_credentials = 'y' ]; then
        ./get_credentials.sh
    fi
}

d_flag() {
    execute="false"
    echo "${TURQUOISE_COLOR}*** Saved user credentials ***${RESET}"
    echo "${DESCRIPTION_FORMAT}"
    cat ${PGK_BASE_DIR}/res/connection_data.json
    echo "${RESET}"
}

c_flag() {
    execute="false"
    echo "${TURQUOISE_COLOR}*** Developer credits  ***${RESET}"
    echo "${DESCRIPTION_FORMAT}"
    echo "Developped with love by Onyr <onyr.official@gmail.com> 2021"
    echo "${RESET}"
}

# flags
while test $# -gt 0; do
    case "$1" in
        --test) 
            t_flag
            if [ $# -gt 0 ]; then shift; fi
            ;;
        -t) 
            t_flag
            if [ $# -gt 0 ]; then shift; fi
            ;;
        --set) 
            s_flag
            if [ $# -gt 0 ]; then shift; fi
            ;;
        -s) 
            s_flag
            if [ $# -gt 0 ]; then shift; fi
            ;;
        --display) 
            d_flag
            if [ $# -gt 0 ]; then shift; fi
            ;;
        -d) 
            d_flag
            if [ $# -gt 0 ]; then shift; fi
            ;;
        --credits) 
            c_flag
            if [ $# -gt 0 ]; then shift; fi
            ;;
        -c) 
            c_flag
            if [ $# -gt 0 ]; then shift; fi
            ;;
        --help) 
            h_flag
            if [ $# -gt 0 ]; then shift; fi
            ;;
        -h) 
            h_flag
            if [ $# -gt 0 ]; then shift; fi
            ;;
        *)
            echo "$1 is not a recognized flag!"
            return 1;
            ;;
    esac
done

# change to directory
cd $execute_location

# pwd in test mode
if [ "${debug}" = "true" ]; then
    pwd
fi



# [run the autoconnect command]
if [ "${execute}" = "true" ]; then
    python3 ../src/main.py
fi



# [delete and recreate a logs/connection_logs.csv if too large]
## variables
LOG_FILEPATH=../logs/connection_logs.csv
MAX_LOG_LINES=1000
nb_lines_log=$(cat $LOG_FILEPATH | wc -l )

if [ $nb_lines_log -gt $MAX_LOG_LINES ]
then
    echo "${TURQUOISE_COLOR}*** log file too large, shrinking it ${RESET}***"
    # keep last 20 logs
    NB_LOGS_TO_KEEP=20
    min_line=$(($nb_lines_log - $NB_LOGS_TO_KEEP))
    #echo $min_line
    text_log="$(sed -n "${min_line},${nb_lines_log}p" ../logs/connection_logs.csv)"
    # WARN : to keed newlines, use echo "$var" instead of echo $var
    #echo "$text_log"
    # replace file content
    echo "date;status" > $LOG_FILEPATH
    echo "$text_log" >> $LOG_FILEPATH
fi


exit 0
