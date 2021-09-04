#/bin/bash

CLUSTER=yru-openedx-prod-1

gcloud container clusters get-credentials ${CLUSTER} \
--region us-west1 \
--project its-artifact-commons

CWD=$(pwd)

cd deploy/prometheus; ./deploy-prometheus-config.bash; cd ${CWD}
