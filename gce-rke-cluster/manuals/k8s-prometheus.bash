#!/bin/bash

CFG=kubeconfig
terraform output its-rancher-demo-kube_config_yaml > ${CFG}.out

LINECOUNT=$(cat ${CFG}.out | wc -l)
let "TOLINE=${LINECOUNT}-1"
sed -ne "2,${TOLINE}p" ${CFG}.out > ${CFG}

export KUBECONFIG=$(pwd)/${CFG}

VERSION=release-0.8
GIT_URL=https://github.com/prometheus-operator/kube-prometheus.git
REPO_PATH=wip

rm -rf ${REPO_PATH}
mkdir -p ${REPO_PATH}
cd ${REPO_PATH}

git clone -b ${VERSION} ${GIT_URL}
cd kube-prometheus

kubectl apply -f manifests/setup
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
kubectl apply -f manifests/