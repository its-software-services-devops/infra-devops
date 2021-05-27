#!/bin/bash

kubectl create ns cert-manager
kubectl apply -f cert-manager-normalized.yaml
