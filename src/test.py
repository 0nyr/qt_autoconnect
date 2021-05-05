import authenticator as auth
import utils

connection_data: dict = utils.json_file_to_data("../res/connection_data.json")

# open browser
quantic_telecom_authenticator: auth.Authenticator = auth.Authenticator(
    connection_data
)
# try a maximum of 3 times to reconnect
quantic_telecom_authenticator.reconnect()
# close browser
quantic_telecom_authenticator.close_browser()

