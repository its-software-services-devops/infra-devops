#!/bin/bash

OUTPUT_FILE=$1
LOKI_MIXIN=loki
LOKI_MIXIN_FILE=${LOKI_MIXIN}-mixin
NAME=loki-alert-rules

if [ -z "${OUTPUT_FILE}" ]
then
  OUTPUT_FILE=generated-loki-rules.yaml
fi

rm -rf ${LOKI_MIXIN}
git clone https://github.com/grafana/${LOKI_MIXIN}.git

cat << 'EOF' > ${LOKI_MIXIN}/production/loki-mixin/config.libsonnet
{
  _config+:: {
    tags: ['loki'],
    per_instance_label: 'pod',
    per_node_label: 'instance',  
  }
}
EOF

docker run -v $(pwd)/${LOKI_MIXIN}/production/loki-mixin/:/data/ \
bitnami/jsonnet:latest > ${LOKI_MIXIN_FILE}.yaml

sed -i -e 's/^/  /' ${LOKI_MIXIN_FILE}.yaml
CONTENT=$(cat ${LOKI_MIXIN_FILE}.yaml)

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
