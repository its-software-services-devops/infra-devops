#!/bin/bash

echo "####"
echo "#### Deploying basic resources ####"

kubectl apply -f nginx-service.yaml
