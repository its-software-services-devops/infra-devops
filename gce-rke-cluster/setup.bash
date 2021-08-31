#/bin/bash

CFG=kubeconfig

terraform output kube_config_yaml > ${CFG}.out

LINECOUNT=$(cat ${CFG}.out | wc -l)
let "TOLINE=${LINECOUNT}-1"
sed -ne "2,${TOLINE}p" ${CFG}.out > ${CFG}

export KUBECONFIG=$(pwd)/${CFG}

cd setup
./setup-prometheus.bash
./setup-cert-manager.bash

CWD=$(pwd)

cd kafka-operator; ./setup-kafka-operator.bash; cd ${CWD}
#cd minio; ./setup-minio.bash; cd ${CWD}
