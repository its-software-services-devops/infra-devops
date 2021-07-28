#/bin/bash

CFG=kubeconfig
terraform output kube_config_yaml > ${CFG}.out

LINECOUNT=$(cat ${CFG}.out | wc -l)
let "TOLINE=${LINECOUNT}-1"
sed -ne "2,${TOLINE}p" ${CFG}.out > ${CFG}

export KUBECONFIG=$(pwd)/${CFG}

CWD=$(pwd)

cd deploy/01_basics; ./deploy-basics.bash; cd ${CWD}
cd deploy/prometheus; ./deploy-prometheus-config.bash; cd ${CWD}
cd deploy/certificates; ./deploy-certificates.bash; cd ${CWD}
cd deploy/cluster-logging; ./deploy-cluster-logging.bash; cd ${CWD}
cd deploy/loki-syslog; ./deploy-loki-syslog.bash; cd ${CWD}
cd deploy/external-dns; ./deploy-external-dns.bash; cd ${CWD}
cd deploy/kafka-log-broker; ./deploy-kafka-cluster.bash; cd ${CWD}
