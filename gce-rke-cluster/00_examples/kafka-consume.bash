#!/bin/bash

docker run \
--env BROKERS=kafka-log-bootstrap.gcp-rke-demo.its-software-services.com:31888 \
deviceinsight/kafkactl:latest consume kafka-syslog-topic \
--tail=5