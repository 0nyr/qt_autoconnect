import authenticator as auth

# json manipulations
def json_file_to_data(json_file_path: str):
    """
    Loads a json file and returns its data
    """
    with open(json_file_path) as json_file:
        data = json.load(json_file)
    return data

connection_data: dict = json_file_to_data("../res/connection_data.json")

quantic_telecom_authenticator: auth.Authenticator = auth.Authenticator(
        connection_data
    )
quantic_telecom_authenticator.reconnect()

