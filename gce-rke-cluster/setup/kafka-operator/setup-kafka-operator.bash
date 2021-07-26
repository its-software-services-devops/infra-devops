#!/bin/bash

NS=kafka-operator

echo "####"
echo "#### Setting Kafka Operator into [${NS}] ####"

kubectl create ns ${NS}
kubectl apply -f 'https://strimzi.io/install/latest?namespace=kafka' -n ${NS}
