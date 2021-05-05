# tuto : https://pythonbasics.org/selenium-find-element/
# tuto : https://www.educba.com/how-to-use-selenium/

import time
import json

from selenium.common.exceptions import WebDriverException
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
import time

# json manipulations
def json_file_to_data(json_file_path: str):
    """
    Loads a json file and returns its data
    """
    with open(json_file_path) as json_file:
        data = json.load(json_file)
    return data


# script code logic
class Authenticator:

    def __init__(self, connection_data: dict):
        self.connection_data: dict = connection_data

    def __get_connection_page_and_enter_credentials():
        """
        Get connection page and enter credentials
        """
        # get connection page
        browser.get(connection_data['url'])

        # write credentials into the fields.
        element = browser.find_element(By.ID, "email")
        element.send_keys(connection_data['email'])
        print(element)

        element = browser.find_element(By.ID, "password")
        element.send_keys(connection_data['password'])
        print(element)

        # validate and go to confirmation page
        element.send_keys(Keys.ENTER)
    
    def is_connection_confirmation_message_detected(timeout: int) -> bool:
        """
        Returns True if the connection confirmation message was detected,
        False otherwise.
        """
        is_detected: bool = False
        try:
            wait = WebDriverWait(browser, timeout)
            # get element by XPath: https://stackoverflow.com/questions/62925043/how-get-the-text-from-the-p-tag-using-xpath-selenium-and-python
            confirmation_text = wait.until(EC.presence_of_element_located((
                By.XPATH,
                "//p[@class='border-r mr-3 pr-3 text-justify border-green-light']"
            ))).text
            print(confirmation_text)
        except selenium.common.exceptions.TimeoutException:
            print("timeout error while waiting page loading")
        except:
            print("unknown error while waiting page loading")
        else:
            # in case of no error
            is_detected = True
        finally:
            return is_detected

    def reconnect(self):
        try:
            MAX_NB_ATTEMPTS: int = 3
            nb_remaining_attempts: int = MAX_NB_ATTEMPTS
            is_connected: bool = False
            browser = webdriver.Firefox()
            while nb_remaining_attempts > 0 and (is_connected == False):
                # reconnect 
                __get_connection_page_and_enter_credentials()

                # check for connection confirmation else retry with longer timeout
                timeout: int = 5*pow((MAX_NB_ATTEMPTS + 1 - nb_remaining_attempts), 3)
                is_connected = __is_connection_confirmation_message_detected(timeout)
                print(
                    "timeout = " + (str)(timeout) + 
                    ", is_connected = " + (str)(is_connected) 
                )
                nb_remaining_attempts = nb_remaining_attempts - 1

                time.sleep(10)
        except WebDriverException:
                print("error, can't get page, possibly no internet to quantic telecom")
        finally:
            browser.close()