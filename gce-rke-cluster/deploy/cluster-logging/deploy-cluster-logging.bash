#!/bin/bash

NS=cluster-logging

echo "####"
echo "#### Deploying Loki-Stack to [${NS}] ####"

kubectl create ns ${NS}
kubectl apply -f rendered-loki-stack.yaml -n ${NS}
