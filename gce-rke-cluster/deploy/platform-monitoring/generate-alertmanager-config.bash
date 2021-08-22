#!/bin/bash

OUTPUT_FILE=$1

if [ -z "${OUTPUT_FILE}" ]
then
  OUTPUT_FILE=generated-alertmanager-config.yaml
fi

export $(cat secrets.txt | sed 's/#.*//g' | xargs)

sed -i "s/__SLACK_URL__/${ALERT_NOTI_SLACK_URL}/g" alertmanager-config-tpl.yaml > ${OUTPUT_FILE}
