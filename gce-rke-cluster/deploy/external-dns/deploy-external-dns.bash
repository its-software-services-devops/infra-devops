#!/bin/bash

NS=external-dns
SECRET=gcp-cloud-dns-key

echo "####"
echo "#### Deploying external-dns to [${NS}] ####"

kubectl create ns ${NS}

kubectl delete secret ${SECRET} -n ${NS}

kubectl create secret generic ${SECRET} \
--from-file=key.json=cloud-dns-rke-demo.json \
-n ${NS}

kubectl apply -f rendered-external-dns.yaml -n ${NS}
