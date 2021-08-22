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

CERTMANAGER_RULES=generated-certmanager-rules.yaml
./generate-alert-rules-certmanager.bash ${CERTMANAGER_RULES}
kubectl apply -f ${CERTMANAGER_RULES} -n ${NS}

ALERTMANAGER_RULES=generated-alertmanager-rules.yaml
./generate-alert-rules-alertmanager.bash ${ALERTMANAGER_RULES}
kubectl apply -f ${ALERTMANAGER_RULES} -n ${NS}
