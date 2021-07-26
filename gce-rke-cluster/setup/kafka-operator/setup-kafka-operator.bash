#!/bin/bash

NS=kafka

echo "####"
echo "#### Setting Kafka Operator into [${NS}] ####"

kubectl create ns ${NS}
kubectl apply -f rendered-kafka-operator.yaml -n ${NS}
