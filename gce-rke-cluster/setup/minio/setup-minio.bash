#!/bin/bash

echo ""
echo "### Setup MinIO ###"

VERSION=v4.2.2
GIT_URL=https://github.com/minio/operator/?ref=${VERSION}

kubectl apply -k ${GIT_URL}
kubectl apply -f minio-console-ing.yaml -n minio-operator
