# Quantic telecom auto reconnect

Tired of having to reconnect to Quantic Telecom all the time ? No worry, qt_autoconnect has your back !

Run the command every 6h periods, hence 4 times a day.

## Installation & configuration

This software is provided as a debian package. Hence, on debian-based distros like Ubuntu, just download the package and install it using `sudo apt install ./package`.

##### required tools

To use this project, you need:

* A firefox browser

###### modifying the project to your needs

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

### techs

* geckodriver
* python3
* selenium


### TODOs

* [X] Modify`preinst` to download and install`geckodriver`.
* [X] Complete`preinst`,`postinst`,`prerm`,`postrm`.
* [X] Modify`preinst` to get the user credentials and initialise the`res/connection_data.json` or print a message telling the user to edit this file.
* [X] Remove`preinst` get user credential and make it a separate command so as not to block graphical package installer !
* [X] Modify`run.sh` to delete the log file if too large.
* [X] Adding cron support and init and rm it automatically.
* [X] Correct Makefile to build properly the debian package using`debuild -uc -us`.
* [ ] Fix cron job installation by debian. Cron file in`/etc/cron.d` not properly removed. However it seems it shouldn't be removed by hand/script... ?
* [ ] Adding colors to Python scripts outputs.
* [ ] Add a flag -d to display user credentials.
* [ ] Add a`man` page.


## Notes

### Selenium

#### Useful links

[selenium doc](https://www.selenium.dev/documentation/en/getting_started/)

[setting up headless browser](https://pythonbasics.org/selenium-firefox-headless/)

[How get the text from the &lt;p&gt; tag using XPath Selenium and Python](https://stackoverflow.com/questions/62925043/how-get-the-text-from-the-p-tag-using-xpath-selenium-and-python)

### cron

#### Useful links

[cron job beginner&#39;s guide](https://ostechnix.com/a-beginners-guide-to-cron-jobs/)

[create cron jobs via debian config files](https://www.debian.org/doc/manuals/maint-guide/dother.en.html)

Use `package.cron.d` - Installed as `/etc/cron.d/package`: for any other time.
