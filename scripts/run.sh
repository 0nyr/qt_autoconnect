#!/bin/sh

# run the autoconnect command
python3 ../src/main.py

# delete and recreate a logs/connection_logs.csv if too large
## variables
LOG_FILEPATH=../logs/connection_logs.csv
MAX_LOG_LINES=500
nb_lines_log=$(cat $LOG_FILEPATH | wc -l )

if [ $nb_lines_log -gt $MAX_LOG_LINES ]
then
    echo "*** log file too large, shrinking it ***"
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
