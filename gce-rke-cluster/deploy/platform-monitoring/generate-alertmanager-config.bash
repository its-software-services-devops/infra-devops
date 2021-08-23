#!/bin/bash

OUTPUT_FILE=$1

if [ -z "${OUTPUT_FILE}" ]
then
  OUTPUT_FILE=generated-alertmanager-config.yaml
fi

export $(cat secrets.txt | sed 's/#.*//g' | xargs)

cp alertmanager-config-secret.yaml ${OUTPUT_FILE}

URL_KEY=$(echo -n ${ALERT_NOTI_SLACK_URL} | base64 -w0)
sed -i "s/__SLACK_URL__/${URL_KEY}/g" ${OUTPUT_FILE}
