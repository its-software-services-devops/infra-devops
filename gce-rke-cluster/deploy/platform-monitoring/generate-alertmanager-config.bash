#!/bin/bash

OUTPUT_FILE=$1

if [ -z "${OUTPUT_FILE}" ]
then
  OUTPUT_FILE=generated-alertmanager-config.yaml
fi

export $(cat secrets.txt | sed 's/#.*//g' | xargs)

cp alertmanager-config-tpl.yaml ${OUTPUT_FILE}
# Use character '#' in the 'sed' command instead of '/' just to escape URL in ALERT_NOTI_SLACK_URL
sed -i "s#__SLACK_URL__#${ALERT_NOTI_SLACK_URL}#g" ${OUTPUT_FILE}
