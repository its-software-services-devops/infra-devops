#/bin/bash

CLUSTER=yru-openedx-prod-1

gcloud container clusters get-credentials ${CLUSTER} \
--region us-west1 \
--project its-artifact-commons

CWD=$(pwd)

cd setup/prometheus; ./setup-prometheus.bash; cd ${CWD}
cd setup/cert-manager; ./setup-cert-manager.bash; cd ${CWD}
