import json

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