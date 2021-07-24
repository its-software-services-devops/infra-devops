#/bin/bash

CLUSTER=its-rancher-demo
CFG=kubeconfig

terraform output ${CLUSTER}-kube_config_yaml > ${CFG}.out

LINECOUNT=$(cat ${CFG}.out | wc -l)
let "TOLINE=${LINECOUNT}-1"
sed -ne "2,${TOLINE}p" ${CFG}.out > ${CFG}

export KUBECONFIG=$(pwd)/${CFG}

cd setup
./setup-prometheus.bash
./setup-cert-manager.bash
