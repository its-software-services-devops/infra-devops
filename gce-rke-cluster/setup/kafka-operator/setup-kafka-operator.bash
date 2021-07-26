#!/bin/bash

NS=kafka-operator
VERSION=0.24.0

echo "####"
echo "#### Setting Kafka Operator into [${NS}] ####"

kubectl create ns ${NS}

kubectl apply -n ${NS} \
-f https://github.com/strimzi/strimzi-kafka-operator/releases/download/${VERSION}/strimzi-crds-${VERSION}.yaml

kubectl apply -f rendered-kafka-operator.yaml -n ${NS}
