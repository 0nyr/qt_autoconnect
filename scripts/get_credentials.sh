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



# tuto : https://ryanstutorials.net/bash-scripting-tutorial/bash-input.php

email=test@test
password=test

# get user credentials
echo "${LIGHT_BLUE_COLOR}enter your ${BOLD}Quantic Telecom email:${RESET}"
read email
echo "${LIGHT_BLUE_COLOR}enter your ${BOLD}Quantic Telecom password:${RESET}"
read password

json="""{
    \"url\": \"https://www.quantic-telecom.net/connexion-reseau\",
    \"email\": \"${email}\",
    \"password\": \"${password}\"
}
"""

echo "${json}" > ../res/connection_data.json
#echo "${json}" > ../tmp/connection_data.json

echo "${TURQUOISE_COLOR}*** user credentials successfuly changed ***${RESET}"


exit 0
