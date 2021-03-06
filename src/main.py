# script to check if the quantic conenction is active
# if active -> add a line in log saying its connected
# else -> reconnect, add a line with date inside logs

import os
import json
import csv
import datetime as dt
import requests
import ssl

# personal imports
import authenticator as auth
import utils
import console

# log file manipulations
def write_in_csv(datalog: dict, csv_file_name: str):
    """
    Write a dictionary of URLs to a CSV file with provided name
    """
    with open(csv_file_name, mode='a', encoding="utf-8", newline='') as file:
        writer = csv.writer(file, delimiter=';')

        writer.writerow([datalog["date"], datalog["status"]])



# important variables
DEBUG: bool = False
connection_data: dict = utils.json_file_to_data("../res/connection_data.json")
connection_test_url: str = "https://www.google.com/"

datalog: dict = {
    "date": "",
    "status": ""
}
datalog_filepath: str = "../logs/connection_logs.csv"

# package building debug
if DEBUG:
    console.println_debug(
        "Python Current Working directory = " + str(os.getcwd())
    )

# functions
def is_connection_available(url: str) -> bool:
    """
    Returns True if a succesful connection is established, False otherwise
    """
    is_connected: bool = False
    try:
        website: requests.Response = requests.get(url)
        if website.status_code == 200:
            is_connected = True
    except ssl.CertificateError: # typical quantic connection error
        is_connected = False
    except:
        is_connected = False
    
    return is_connected


# script code logic
console.println_fg_color(
    "*** Performing Quantic Connection test ***", 
    console.ANSIColorCode.LIGHT_BLUE_C
)
datalog["date"] = dt.datetime.now().strftime("%Y_%m_%d_%H_%M_%S")

if is_connection_available(connection_test_url):
    datalog["status"] = "connected"
else:
    datalog["status"] = "not_connected"

    # open browser
    quantic_telecom_authenticator: auth.Authenticator = auth.Authenticator(
        connection_data
    )
    # try a maximum of 3 times to reconnect
    quantic_telecom_authenticator.reconnect()
    # close browser
    quantic_telecom_authenticator.close_browser()

    # test connection again
    if is_connection_available(connection_test_url):
        datalog["status"] = "re_connected"

# WARN : if PermissionError: Permission denied, check UNIX rights (666)
write_in_csv(datalog, datalog_filepath)
utils.print_pretty_json(datalog)

console.println_fg_color(
    "*** Quantic Connection test done ***", 
    console.ANSIColorCode.LIGHT_BLUE_C
)
