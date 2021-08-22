#!/bin/bash

NS=platform-monitoring
CERT_MANAGER_MIXIN=cert-manager-mixin

git clone https://gitlab.com/uneeq-oss/${CERT_MANAGER_MIXIN}.git

docker run -v $(pwd)/${CERT_MANAGER_MIXIN}/:/data/ \
bitnami/jsonnet:latest \
-S /data/lib/alerts.jsonnet > ${CERT_MANAGER_MIXIN}.yaml
