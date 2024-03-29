#!/bin/bash

NAME1=$1

if [ -z "${NAME1}" ]
then
  NAME1=generated-kafka-alert.yaml
fi

# Download from the pre-generated ones
ALERT_URL=https://raw.githubusercontent.com/strimzi/strimzi-kafka-operator/main/examples/metrics/prometheus-install/prometheus-rules.yaml
ALERT_NAME=kafka-alert

curl ${ALERT_URL} > downloaded-${ALERT_NAME}.yaml

# Get only lines start from line number 9
ALERT_CONTENT=$(sed 1,8d downloaded-${ALERT_NAME}.yaml)

cat << EOF > ${NAME1}
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: ${ALERT_NAME}
  labels:
    app: kube-prometheus-stack
    release: kube-prometheus-stack
spec:
${ALERT_CONTENT}
EOF
