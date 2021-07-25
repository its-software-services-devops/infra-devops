#!/bin/bash

NS=loki-syslog
SECRET=loki-gcs-bucket-key

echo "####"
echo "#### Deploying Loki for Syslog to [${NS}] ####"

kubectl delete secret ${SECRET} -n ${NS}

kubectl create secret generic ${SECRET} \
--from-file=service-account.json=cloud-dns-rke-demo.json \
-n ${NS}

kubectl create ns ${NS}
kubectl apply -f rendered-loki-syslog.yaml -n ${NS}
