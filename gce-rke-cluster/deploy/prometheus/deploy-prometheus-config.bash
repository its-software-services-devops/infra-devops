#!/bin/bash

NS=monitoring

echo "####"
echo "#### Deploying prometheus config to [${NS}] ####"

kubectl apply -f rendered-prometheus-config.yaml
kubectl apply -f prometheus-ing.yaml

kubectl apply -f rendered-grafana-k8s.yaml -n ${NS}
kubectl apply -f grafana-k8s-ing.yaml -n ${NS}

kubectl patch prometheus k8s -n monitoring --patch --type merge "$(cat prometheus-patch.yaml)"
