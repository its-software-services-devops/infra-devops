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

PROMETHEUS_RULES=generated-prometheus-rules.yaml
./generate-alert-rules-prometheus.bash ${PROMETHEUS_RULES}
kubectl apply -f ${PROMETHEUS_RULES} -n ${NS}

LOKI_RULES1=generated-loki-alert.yaml
LOKI_RULES2=generated-loki-record.yaml
./generate-alert-rules-loki.bash ${LOKI_RULES1} ${LOKI_RULES2}
kubectl apply -f ${LOKI_RULES1} -n ${NS}
kubectl apply -f ${LOKI_RULES2} -n ${NS}

KAFKA_RULES=generated-kafka-rules.yaml
./generate-alert-rules-kafka.bash ${KAFKA_RULES}
kubectl apply -f ${KAFKA_RULES} -n ${NS}

# Put this to the very end after "rendered-prometheus-stack.yaml"
ALERTMANAGER_CONFIG=generated-alertmanager-config.yaml
./generate-alertmanager-config.bash ${ALERTMANAGER_CONFIG}
kubectl apply -f ${ALERTMANAGER_CONFIG} -n ${NS}


# Grafana here
kubectl apply -f rendered-grafana-platform.yaml -n ${NS}
kubectl apply -f grafana-platform-ing.yaml -n ${NS}
