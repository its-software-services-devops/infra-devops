#!/bin/bash

VERSION=v0.0.8

sudo docker run \
-v $(pwd)/output:/wip/output \
-v ${HOME}/.config/gcloud:/root/.config/gcloud \
-e IASC_VCS_MODE=git \
-e IASC_VCS_URL='https://github.com/its-software-services-devops/infra-devops.git' \
-e IASC_VCS_REF=develop \
-e IASC_VCS_FOLDER=gce-rke-cluster \
-e IASC_VAULT_SECRETS=gs://its-config-params/gcp-rke-demo-cluster/secrets.txt \
-it gcr.io/its-artifact-commons/iasc:${VERSION} \
init

sudo chown -R admin:admin output