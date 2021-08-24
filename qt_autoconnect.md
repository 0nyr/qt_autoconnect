# qt-autoconnect

### Useful links

## commands

##### debian package

``debuild -uc -us``: Inside `<package>`-`<version>` directory, build the debian package.insideL. This command has been authomatized inside the `Makefile` of the project to then move out files inside

`dpkg -l <package_name>`: Check if a package is already installed.

`sudo apt install ./qt-autoconnect_0.1.0_amd64.deb`: install a debian package from a `.deb` file using `apt` package manager.

`sudo apt remove qt-autoconnect`: remove/uninstall an already installed package.

##### cron

`sudo service cron status`: show `cron` service status

`sudo service cron restart`: restart `cron`.

### qt-autoconnect 0.1.3+

Simple launch from command line:

1. Go in the`src/` folder.
2. Use`conda`:`conda activate py39`
3. Run the program:`python main.py`

# troubleshooting

##### program terminating with error

The error stack trace is given below:

```shell
(base) onyr@aezyr:~$ qt-autoconnect 
*** Performing Quantic Connection test ***
Traceback (most recent call last):
  File "../src/main.py", line 76, in <module>
    quantic_telecom_authenticator: auth.Authenticator = auth.Authenticator(
  File "/opt/qt_autoconnect/src/authenticator/authenticator.py", line 29, in __init__
    self.browser = webdriver.Firefox(firefox_options = fireFoxOptions)
  File "/home/onyr/anaconda3/lib/python3.8/site-packages/selenium/webdriver/firefox/webdriver.py", line 160, in __init__
    self.service = Service(
  File "/home/onyr/anaconda3/lib/python3.8/site-packages/selenium/webdriver/firefox/service.py", line 44, in __init__
    log_file = open(log_path, "a+") if log_path is not None and log_path != "" else None
PermissionError: [Errno 13] Permission denied: 'geckodriver.log'

```

Since it seems to come froim a Unix right problem, I added some code to show the current working directory of the python runtime:

Inside `/home/onyr/anaconda3/lib/python3.8/site-packages/selenium/webdriver/firefox/service.py`:

```python
# debug onyr start
        def __print_cwd() -> None:
            import os
            print(
                "(onyr) Python Current Working directory = " + str(os.getcwd())
            )
        __print_cwd()
        # debug onyr end
```

This gives the following stack trace:

```shell
(base) onyr@aezyr:~/anaconda3/lib/python3.8/site-packages/selenium/webdriver/firefox$ qt-autoconnect 
*** Performing Quantic Connection test ***
Python Current Working directory = /opt/qt_autoconnect/scripts
Traceback (most recent call last):
  File "../src/main.py", line 76, in <module>
    quantic_telecom_authenticator: auth.Authenticator = auth.Authenticator(
  File "/opt/qt_autoconnect/src/authenticator/authenticator.py", line 29, in __init__
    self.browser = webdriver.Firefox(firefox_options = fireFoxOptions)
  File "/home/onyr/anaconda3/lib/python3.8/site-packages/selenium/webdriver/firefox/webdriver.py", line 160, in __init__
    self.service = Service(
  File "/home/onyr/anaconda3/lib/python3.8/site-packages/selenium/webdriver/firefox/service.py", line 53, in __init__
    log_file = open(log_path, "a+") if log_path is not None and log_path != "" else None
```

The problem seems to come from the fact that the current working directory is `/opt/qt_autoconnect/scripts/` and not `/opt/qt_autoconnect/src/` where the `geckodriver.log` is.
