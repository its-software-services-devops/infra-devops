#!/bin/bash

export RSYSLOG_DEBUG=NoStdOut
export RSYSLOG_DEBUGLOG=/var/log/rsyslog/debug.log

/usr/sbin/rsyslogd -i /var/run/syslog.pid -f /etc/rsyslog.conf -dn
tee -a ${RSYSLOG_DEBUGLOG}