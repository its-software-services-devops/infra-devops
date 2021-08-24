#!/bin/bash

OUTPUT_FILE=$1
PROMETHEUS_MIXIN=prometheus
PROMETHEUS_MIXIN_FILE=${PROMETHEUS_MIXIN}-mixin
NAME=prometheus-alert-rules

if [ -z "${OUTPUT_FILE}" ]
then
  OUTPUT_FILE=generated-prometheus-rules.yaml
fi

rm -rf ${PROMETHEUS_MIXIN}
git clone https://github.com/prometheus/${PROMETHEUS_MIXIN}.git

cat << 'EOF' > ${PROMETHEUS_MIXIN}/documentation/prometheus-mixin/config.libsonnet
{
  _config+:: {
    prometheusSelector: 'job="prometheus"',
    prometheusHAGroupLabels: '',
    prometheusName: '{{$labels.instance}}',
    prometheusHAGroupName: '{{$labels.job}}',
    nonNotifyingAlertmanagerRegEx: @'',
  },
}
EOF

docker run -v $(pwd)/${PROMETHEUS_MIXIN}/documentation/prometheus-mixin/:/data/ \
bitnami/jsonnet:latest \
-S /data/alerts.jsonnet > ${PROMETHEUS_MIXIN_FILE}.yaml

sed -i -e 's/^/  /' ${PROMETHEUS_MIXIN_FILE}.yaml
CONTENT=$(cat ${PROMETHEUS_MIXIN_FILE}.yaml)

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
