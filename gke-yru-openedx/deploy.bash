#/bin/bash

CLUSTER=yru-openedx-prod-1

gcloud container clusters get-credentials ${CLUSTER} \
--region us-west1 \
--project its-artifact-commons

CWD=$(pwd)

cd deploy/nginx-ingress; ./deploy-nginx.bash; cd ${CWD}
cd deploy/prometheus; ./deploy-prometheus-config.bash; cd ${CWD}
#external DNS does not work now
#cd deploy/external-dns; ./deploy-external-dns.bash; cd ${CWD}
cd deploy/loki-log; ./deploy-loki-log.bash; cd ${CWD}
