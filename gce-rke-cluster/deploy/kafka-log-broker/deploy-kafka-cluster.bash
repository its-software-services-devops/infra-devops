#!/bin/bash

NS=kafka-log-broker

echo "####"
echo "#### Deploying kafka broker to [${NS}] ####"

kubectl create ns ${NS}

kubectl apply -f kafka-cluster.yaml -n ${NS}
kubectl apply -f kafka-syslog-topic.yaml -n ${NS}
kubectl apply -f kafka-user.yaml -n ${NS}
kubectl apply -f service.yaml -n ${NS}
