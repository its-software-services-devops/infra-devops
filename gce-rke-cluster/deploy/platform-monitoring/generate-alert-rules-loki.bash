#!/bin/bash

NAME1=$1
NAME2=$2

if [ -z "${NAME1}" ]
then
  NAME1=generated-loki-alert.yaml
fi

if [ -z "${NAME2}" ]
then
  NAME2=generated-loki-rule.yaml
fi

# Download from the pre-generated ones
ALERT_URL=https://raw.githubusercontent.com/monitoring-mixins/website/master/assets/loki/alerts.yaml
RULE_URL=https://raw.githubusercontent.com/monitoring-mixins/website/master/assets/loki/rules.yaml

ALERT_NAME=loki-alert
RULE_NAME=loki-rule

curl ${ALERT_URL} > downloaded-${ALERT_NAME}.yaml
sed -i -e 's/^/  /' downloaded-${ALERT_NAME}.yaml

curl ${RULE_URL} > downloaded-${RULE_NAME}.yaml
sed -i -e 's/^/  /' downloaded-${RULE_NAME}.yaml

ALERT_CONTENT=$(cat downloaded-${ALERT_NAME}.yaml)
RULE_CONTENT=$(cat downloaded-${RULE_NAME}.yaml)

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

cat << EOF > ${NAME2}
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: ${RULE_NAME}
  labels:
    app: kube-prometheus-stack
    release: kube-prometheus-stack
spec:
${RULE_CONTENT}
EOF
