#!/bin/bash

NS=platform-monitoring

echo "####"
echo "#### Deploying prometheus to [${NS}] ####"

kubectl create ns ${NS}
kubectl apply -f rendered-prometheus-stack.yaml -n ${NS}
kubectl apply -f prometheus-ing.yaml -n ${NS}

kubectl apply -f kafka-pod-monitor.yaml -n ${NS}
kubectl apply -f certmanager-service-monitor.yaml -n ${NS}
kubectl apply -f vector-service-monitor.yaml -n ${NS}
kubectl apply -f loki-syslog-service-monitor.yaml -n ${NS}