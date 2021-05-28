#!/bin/bash

kubectl create secret generic gcp-cloud-dns-account-key \
--from-file=service-account.json=cloud-dns-rke-demo.json \
-n cert-manager

kubectl apply -f cluster-certs.yaml
