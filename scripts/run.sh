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

# [cd to location]
TEST_SCRIPTS_DIR=.
SCRIPTS_DIR=/opt/qt_autoconnect/scripts
cd $SCRIPTS_DIR

# [command params]
./command_params.sh "$@"



# [run the autoconnect command]
python3 ../src/main.py



# [delete and recreate a logs/connection_logs.csv if too large]
## variables
LOG_FILEPATH=../logs/connection_logs.csv
MAX_LOG_LINES=500
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
