#!/bin/bash

MANIFEST_FILE=setup/nginx-service.yaml

kubectl apply -f ${MANIFEST_FILE}
