#!/bin/bash

NS=loki-syslog

echo "####"
echo "#### Deploying Loki for Syslog to [${NS}] ####"

kubectl create ns ${NS}
kubectl apply -f rendered-loki-syslog.yaml -n ${NS}
