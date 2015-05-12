#!/bin/bash

# get index.html from Pypi
wget --no-check-certificate -O /var/local/pypi/index.html http://pypi.python.org/simple && chown 1000:1000 /var/local/pypi/index.html
# start cron in foreground
cron -f
