#!/bin/bash

NS=monitoring

echo "####"
echo "#### Deploying prometheus config to [${NS}] ####"

kubectl apply -f rendered-prometheus-config.yaml
#Use this for debug only
kubectl apply -f prometheus-ing.yaml

kubectl apply -f rendered-grafana-k8s.yaml -n ${NS}
kubectl apply -f grafana-k8s-ing.yaml -n ${NS}

kubectl label ns monitoring --overwrite monitoring=true
kubectl patch prometheus k8s -n monitoring --type merge --patch "$(cat prometheus-patch.yaml)"

kubectl annotate svc prometheus-k8s cloud.google.com/neg='{"ingress": true}' --overwrite -n ${NS}
kubectl annotate svc grafana-k8s cloud.google.com/neg='{"ingress": true}' --overwrite -n ${NS}
