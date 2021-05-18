#!/bin/bash

VERSION=1.5.0
ECK_URL=https://download.elastic.co/downloads/eck/${VERSION}/all-in-one.yaml
kubectl apply -f ${ECK_URL}
