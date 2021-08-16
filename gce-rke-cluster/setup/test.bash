#!/bin/bash

helm template certmanager \
cert-manager/cert-manager \
-f cert-manager.yaml \
--namespace xxxxxx \
--version 1.3.1
