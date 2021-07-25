#!/bin/bash

sudo docker run -it \
-v "$PWD/syslog-ng.conf":/etc/syslog-ng/syslog-ng.conf \
-v "/var/log/secure":/data/secure \
-v "/var/log/messages":/data/messages \
balabit/syslog-ng:latest --no-caps -edvt