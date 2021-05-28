#!/bin/bash

NS=cert-manager
SECRET=gcp-cloud-dns-account-key

kubectl delete secret ${SECRET} -n ${NS}

kubectl create secret generic ${SECRET} \
--from-file=service-account.json=cloud-dns-rke-demo.json \
-n ${NS}

kubectl apply -f cluster-certs.yaml
