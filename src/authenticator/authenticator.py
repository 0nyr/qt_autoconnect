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

import console

# script code logic
class Authenticator:

    connection_data = None
    browser = None

    def __init__(self, connection_data: dict, is_browser_headless: bool = True):
        self.connection_data: dict = connection_data
        # by default, use a headless browser
        if is_browser_headless:
            fireFoxOptions = webdriver.FirefoxOptions()
            fireFoxOptions.set_headless()
            self.browser = webdriver.Firefox(firefox_options = fireFoxOptions)
        else:
            self.browser = webdriver.Firefox()
        

    def __get_connection_page_and_enter_credentials(self):
        """
        Get connection page and enter credentials
        """
        # get connection page
        self.browser.get(self.connection_data['url'])

        # write credentials into the fields.
        element = self.browser.find_element(By.ID, "email")
        element.send_keys(self.connection_data['email'])
        console.println_fg_color(element, console.ANSIColorCode.GREY3_C)

        element = self.browser.find_element(By.ID, "password")
        element.send_keys(self.connection_data['password'])
        console.println_fg_color(element, console.ANSIColorCode.GREY3_C)

        # validate and go to confirmation page
        element.send_keys(Keys.ENTER)
    
    def close_browser(self):
        self.browser.close()
    
    def __is_connection_confirmation_message_detected(self, timeout: int) -> bool:
        """
        Returns True if the connection confirmation message was detected,
        False otherwise.
        """
        is_detected: bool = False
        try:
            wait = WebDriverWait(self.browser, timeout)
            # get element by XPath: https://stackoverflow.com/questions/62925043/how-get-the-text-from-the-p-tag-using-xpath-selenium-and-python
            confirmation_text = wait.until(EC.presence_of_element_located((
                By.XPATH,
                "//p[@class='border-r mr-3 pr-3 text-justify border-green-light']"
            ))).text
            console.println_fg_color(
                confirmation_text, console.ANSIColorCode.PASSED_C
            )
        except selenium.common.exceptions.TimeoutException:
            console.println_fg_color(
                "timeout error while waiting page loading", 
                console.ANSIColorCode.LIGHT_ORANGE_C
            )
        except:
            console.println_fg_color(
                "unknown error while waiting page loading", 
                console.ANSIColorCode.LIGHT_ORANGE_C
            )
        else:
            # in case of no error
            is_detected = True
        finally:
            return is_detected

    def reconnect(self):
        """
        Function to call to reconnect. Try MAX_NB_ATTEMPTS times to reconnect
        """
        try:
            MAX_NB_ATTEMPTS: int = 3
            nb_remaining_attempts: int = MAX_NB_ATTEMPTS
            is_connected: bool = False
            while nb_remaining_attempts > 0 and (is_connected == False):
                # reconnect 
                self.__get_connection_page_and_enter_credentials()

                # check for connection confirmation else retry with longer timeout
                timeout: int = 45*pow((MAX_NB_ATTEMPTS + 1 - nb_remaining_attempts), 2)
                is_connected = self.__is_connection_confirmation_message_detected(timeout)
                attemp_info: str = str(
                    "timeout = " + (str)(timeout) + 
                    ", is_connected = " + (str)(is_connected)
                )
                console.println_fg_color(
                    attemp_info, 
                    console.ANSIColorCode.TURQUOISE_C
                )
                nb_remaining_attempts = nb_remaining_attempts - 1

                time.sleep(10)
        except WebDriverException:
                console.println_fg_color(
                    "error, can't get page, possibly no internet to quantic telecom", 
                    console.ANSIColorCode.LIGHT_ORANGE_C
                )
