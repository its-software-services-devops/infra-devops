#!/bin/bash

NS=ingress-nginx

echo "####"
echo "#### Deploying nginx config to [${NS}] ####"

kubectl create ns ${NS}

kubectl apply -f gcp-manage-certs.yaml -n ${NS}
kubectl apply -f nginx-ing.yaml -n ${NS}

kubectl apply -f rendered-nginx.yaml -n ${NS}
