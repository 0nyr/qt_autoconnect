MAILTO=email@example.com
PATH=/usr/local/bin

@reboot root qt-autoconnect >/dev/null 2>&1
0 4 * * * root qt-autoconnect >/dev/null 2>&1
0 10 * * * root qt-autoconnect >/dev/null 2>&1
0 16 * * * root qt-autoconnect >/dev/null 2>&1
0 22 * * * root qt-autoconnect >/dev/null 2>&1
