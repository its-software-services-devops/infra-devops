#!/bin/bash

VERSION=v0.0.6

sudo docker run \
-v $(pwd)/gcp-evermed-infra-prod:/wip/output \
-e IASC_VCS_MODE=git \
-e IASC_VCS_URL='git@gitlab.com:ever-medical-technologies/devops/iasc/gcp-evermed-infra-prod.git' \
-e IASC_VCS_REF=main \
-e IASC_VCS_FOLDER=gce-rke-manager \
-it gcr.io/its-artifact-commons/iasc:${VERSION} \
init

#-e IASC_VAULT_SECRETS=gs://its-config-params/gcp-rke-demo-cluster/secret.txt \
