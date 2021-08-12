#!/bin/bash

VERSION=v0.0.7

sudo docker run \
-v $(pwd)/output:/wip/output \
-v ${HOME}/.config/gcloud:/root/.config/gcloud \
-e IASC_VCS_MODE=git \
-e IASC_VCS_URL='https://github.com/its-software-services-devops/infra-devops.git' \
-e IASC_VCS_REF=develop \
-e IASC_VCS_FOLDER=gke-logs-cluster \
-it gcr.io/its-artifact-commons/iasc:${VERSION} \
init
