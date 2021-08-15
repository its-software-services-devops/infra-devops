#!/bin/bash

NS=platform-monitoring

echo "####"
echo "#### Deploying prometheus to [${NS}] ####"

kubectl create ns ${NS}
kubectl apply -f prometheus.yaml -n ${NS}
