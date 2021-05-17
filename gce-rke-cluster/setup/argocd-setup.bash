#!/bin/bash

VERSION=release-2.0
ARGOCD_URL=https://raw.githubusercontent.com/argoproj/argo-cd/${VERSION}/manifests/install.yaml
NAMESPACE=argocd
           
kubectl create ns ${NAMESPACE}
kubectl apply -n ${NAMESPACE} -f ${ARGOCD_URL}
