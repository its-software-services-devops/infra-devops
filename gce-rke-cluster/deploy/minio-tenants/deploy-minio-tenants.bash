#!/bin/bash

NS1=minio-syslog

MINIO_SECRET=minio-secret.yaml
CONSOLE_SECRET=console-secret.yaml

ALIAS1=minio-syslog
ALIAS1_URL=https://minio-syslog.gcp-rke-demo.its-software-services.com

echo ""
echo "### Deploying MinIO tenants to [${NS1}] ###"

kubectl create ns ${NS1}

# Dot script to preserve ENV
. ./export-secrets.bash secrets.txt

### Creaet MinIO used secrets ###

cat << EOF > ${MINIO_SECRET}
---
## Secret to be used as MinIO Root Credentials
apiVersion: v1
kind: Secret
metadata:
  name: minio-creds-secret
type: Opaque
data:
  accesskey: $(echo -n ${ACCESS_KEY} | base64)
  secretkey: $(echo -n ${SECRET_KEY} | base64)
EOF

cat << EOF > ${CONSOLE_SECRET}
---
## Secret to be used for MinIO Console
apiVersion: v1
kind: Secret
metadata:
  name: console-secret
type: Opaque
data:
  CONSOLE_PBKDF_PASSPHRASE: $(echo -n ${CONSOLE_PBKDF_PASSPHRASE} | base64)
  CONSOLE_PBKDF_SALT: $(echo -n ${CONSOLE_PBKDF_SALT} | base64)
  CONSOLE_ACCESS_KEY: $(echo -n ${CONSOLE_ACCESS_KEY} | base64)
  CONSOLE_SECRET_KEY: $(echo -n ${CONSOLE_SECRET_KEY} | base64)
EOF

kubectl apply -f ${MINIO_SECRET} -n ${NS1}
kubectl apply -f ${CONSOLE_SECRET} -n ${NS1}

kubectl apply -f tenant.yaml -n ${NS1}
kubectl apply -f minio-syslog-ing.yaml -n ${NS1}
