#!/bin/bash

NS=loki-log

echo "####"
echo "#### Deploying Loki-Stack to [${NS}] ####"

kubectl create ns ${NS}
kubectl apply -f rendered-loki-stack.yaml -n ${NS}
