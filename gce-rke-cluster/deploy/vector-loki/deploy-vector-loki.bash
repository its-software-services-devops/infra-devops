#!/bin/bash

NS=vector-loki

echo "####"
echo "#### Deploying vector to [${NS}] ####"

kubectl create ns ${NS}

kubectl apply -f rendered-vector-loki.yaml -n ${NS}
