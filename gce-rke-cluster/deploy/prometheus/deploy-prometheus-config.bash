#!/bin/bash

kubectl apply -f rendered-prometheus-config.yaml
kubectl apply -f prometheus-ing.yaml

