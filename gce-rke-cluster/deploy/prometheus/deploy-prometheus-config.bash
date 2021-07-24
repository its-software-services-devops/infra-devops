#!/bin/bash

echo "####"
echo "#### Deploying prometheus config ####"

kubectl apply -f rendered-prometheus-config.yaml
kubectl apply -f prometheus-ing.yaml
kubectl apply -f rendered-grafana-k8s.yaml
