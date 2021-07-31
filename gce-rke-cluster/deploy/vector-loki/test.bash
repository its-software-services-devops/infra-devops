#!/bin/bash

helm template test-vector-aggregator \
vector-nightly/vector-aggregator \
-f vector-loki.yaml \
--version 0.16.0-nightly-2021-07-31
