#!/bin/bash

echo "####"
echo "#### Deploying basic resources ####"

kubectl apply -f nginx-service.yaml

#kubectl apply -f nginx-service-neg.yaml
#kubectl apply -f nginx-ingress-neg.yaml
