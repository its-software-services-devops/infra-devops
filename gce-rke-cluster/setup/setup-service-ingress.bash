#!/bin/bash

kubectl apply -f setup/nginx-service.yaml
kubectl apply -f setup/prometheus-ing.yaml
