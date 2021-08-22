#!/bin/bash

OUTPUT_FILE=$1
ALERT_MANAGER_MIXIN=alertmanager
ALERT_MANAGER_MIXIN_FILE=${ALERT_MANAGER_MIXIN}-mixin
NAME=alertmanager-alert-rules

if [ -z "${OUTPUT_FILE}" ]
then
  OUTPUT_FILE=generated-alertmanager-rules.yaml
fi

rm -rf ${ALERT_MANAGER_MIXIN}
git clone https://github.com/prometheus/${ALERT_MANAGER_MIXIN}.git

cat << 'EOF' > ${ALERT_MANAGER_MIXIN}/doc/alertmanager-mixin/config.libsonnet
{
  alertmanagerSelector: 'job="kube-prometheus-stack-alertmanager"',
}
EOF

docker run -v $(pwd)/${ALERT_MANAGER_MIXIN}/doc/alertmanager-mixin/:/data/ \
bitnami/jsonnet:latest \
-S /data/alerts.jsonnet > ${ALERT_MANAGER_MIXIN_FILE}.yaml

sed -i -e 's/^/  /' ${ALERT_MANAGER_MIXIN_FILE}.yaml
CONTENT=$(cat ${ALERT_MANAGER_MIXIN_FILE}.yaml)

cat << EOF > ${OUTPUT_FILE}
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: ${NAME}
  labels:
    app: kube-prometheus-stack
    release: kube-prometheus-stack
spec:
${CONTENT}
EOF
