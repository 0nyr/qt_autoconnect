# Quantic telecom auto reconnect

Tired of having to reconnect to Quantic Telecom all the time ? No worry, qt_autoconnect has your back !

### Useful links

##### selenium

[How get the text from the &lt;p&gt; tag using XPath Selenium and Python](https://stackoverflow.com/questions/62925043/how-get-the-text-from-the-p-tag-using-xpath-selenium-and-python)

## Installation & configuration

Make sure to rename the `connection_data_example.json` into `connection_data.json` and to put your credentials inside.

```json
{
    "url": "https://www.quantic-telecom.net/connexion-reseau",
    "email": "surname.name@insa-lyon.fr",
    "password": "strong_password"
}
```

## The project

Objective: From time to time, the connection to quantic telecom fails and need to be reestablished by giving the credentials to the connection page. This is not only borring, but is also a problem when one wants one's computer to stay connected to the network.

Idea: create a command-like program that automatically checks from time to time if the pc is still connected, else reconnect to the internet.

`https://www.quantic-telecom.net/connexion-reseau` : The URL of connection page to connect to quantic-telecom.

connection requests

```
_token	"gJKPmXZhPBzEEn53Xrr1jlpbVcVWfzZHz4YJwMBG"
email	"florian.rascoussier@insa-lyon.fr"
password	"lololhh"

_token	"gJKPmXZhPBzEEn53Xrr1jlpbVcVWfzZHz4YJwMBG"
email	"florian.rascoussier@insa-lyon.fr"
password	"lololhd"


```
