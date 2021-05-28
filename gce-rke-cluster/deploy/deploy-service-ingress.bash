#!/bin/bash

kubectl apply -f deploy/nginx-service.yaml
kubectl apply -f deploy/prometheus-ing.yaml
