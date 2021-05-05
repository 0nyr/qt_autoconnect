# script to check if the quantic conenction is active
# if active -> add a line in log saying its connected
# else -> reconnect, add a line with date inside logs

import json
import csv
import os
import pandas as pd
import datetime as dt
import requests
import ssl

from urllib.parse import urlparse, urljoin
from bs4 import BeautifulSoup

import authenticator as auth

# json manipulations
def json_file_to_data(json_file_path: str):
    """
    Loads a json file and returns its data
    """
    with open(json_file_path) as json_file:
        data = json.load(json_file)
    return data

def print_pretty_json(json_data: dict):
    """
    Print a python json object (dict) prettified
    """
    json_formatted_str: str = json.dumps(json_data, indent=4)
    print(json_formatted_str)

# log file manipulations
def write_in_csv(datalog: dict, csv_file_name: str):
    """
    Write a dictionary of URLs to a CSV file with provided name
    """
    with open(csv_file_name, mode='a', encoding="utf-8", newline='') as file:
        writer = csv.writer(file, delimiter=';')

        writer.writerow([datalog["date"], datalog["status"]])



# important variables
connection_data: dict = json_file_to_data("../res/connection_data.json")
connection_test_url: str = "https://www.google.com/"

datalog: dict = {
    "date": "",
    "status": ""
}
datalog_filepath: str = "logs/connection_logs.csv"

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
print("*** Performing Quantic Connection test ***")
datalog["date"] = dt.datetime.now().strftime("%Y_%m_%d_%H_%M_%S")

if is_connection_available(connection_test_url):
    datalog["status"] = "connected"
else:
    datalog["status"] = "not_connected"

    # TODO : try reconnect to Quantic Telecom
    # hard, need to get cookies & _token generated from frontend javascript
    # this cannot be done by a simple POST request
    # TODO : plug the test_3_autoconnect.py script here
    quantic_telecom_authenticator: auth.Authenticator = auth.Authenticator(
        connection_data
    )
    quantic_telecom_authenticator.reconnect()

    # test connection again
    if is_connection_available(connection_test_url):
        datalog["status"] = "re_connected"

write_in_csv(datalog, datalog_filepath)
print_pretty_json(datalog)

print("*** Quantic Connection test done ***")
