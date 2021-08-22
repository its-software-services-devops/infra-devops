#!/bin/bash

NS=platform-monitoring
CERT_MANAGER_MIXIN=cert-manager-mixin

git clone https://gitlab.com/uneeq-oss/${CERT_MANAGER_MIXIN}.git
#jsonnet -S ${CERT_MANAGER_MIXIN}/lib/alerts.jsonnet > ${CERT_MANAGER_MIXIN}.yaml

docker run --name jsonnet bitnami/jsonnet:latest \
-v $(pwd)/${CERT_MANAGER_MIXIN}/:/data/ \
-S /data/lib/alerts.jsonnet > /data/${CERT_MANAGER_MIXIN}.yaml \
