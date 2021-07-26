#!/bin/bash

NS=kafka-operator

kubectl create ns ${NS}
kubectl apply -f rendered-kafka-operator.yaml -n ${NS}
