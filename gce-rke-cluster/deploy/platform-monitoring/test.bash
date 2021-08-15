#!/bin/bash

helm template platform-monitor \
prometheus-community/kube-prometheus-stack \
-f prometheus.yaml \
--namespace platform-monitoring \
--version 17.2.1
