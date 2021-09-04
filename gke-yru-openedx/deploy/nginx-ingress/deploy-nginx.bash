#!/bin/bash

NS=ingress-nginx

echo "####"
echo "#### Deploying nginx config to [${NS}] ####"

kubectl apply -f rendered-nginx.yaml -n ${NS}

#kubectl annotate svc prometheus-k8s cloud.google.com/neg='{"ingress": true}' --overwrite -n ${NS}
