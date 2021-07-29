#!/bin/bash

docker run \
--env BROKERS=kafka-log-bootstrap.gcp-rke-demo.its-software-services.com:31888 \
deviceinsight/kafkactl:latest produce kafka-syslog-topic \
--key="test-key-a" \
--value="test-value-$(date)"

#docker run \
#-it edenhill/kafkacat:1.6.0 \
#-b kafka-log-bootstrap.gcp-rke-demo.its-software-services.com:31888 \
#-L