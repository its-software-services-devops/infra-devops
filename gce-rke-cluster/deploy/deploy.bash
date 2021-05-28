#/bin/bash

CFG=kubeconfig
terraform output its-rancher-demo-kube_config_yaml > ${CFG}.out

LINECOUNT=$(cat ${CFG}.out | wc -l)
let "TOLINE=${LINECOUNT}-1"
sed -ne "2,${TOLINE}p" ${CFG}.out > ${CFG}

export KUBECONFIG=$(pwd)/${CFG}

# Certificates deployment should be at the very last step
./deploy-certificates.bash
./deploy-service-ingress.bash