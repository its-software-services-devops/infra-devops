#/bin/bash

CFG=kubeconfig
terraform output kube_config_yaml > ${CFG}.out

LINECOUNT=$(cat ${CFG}.out | wc -l)
let "TOLINE=${LINECOUNT}-1"
sed -ne "2,${TOLINE}p" ${CFG}.out > ${CFG}

export KUBECONFIG=$(pwd)/${CFG}

CWD=$(pwd)

cd deploy/01-basics; ./deploy-basics.bash; cd ${CWD}
cd deploy/prometheus; ./deploy-prometheus-config.bash; cd ${CWD}
cd deploy/cluster-logging; ./deploy-cluster-logging.bash; cd ${CWD}
# Put minio before loki-syslog
cd deploy/minio-tenants; ./deploy-minio-tenants.bash; cd ${CWD}
cd deploy/loki-syslog; ./deploy-loki-syslog.bash; cd ${CWD}
cd deploy/external-dns; ./deploy-external-dns.bash; cd ${CWD}
cd deploy/kafka-log-broker; ./deploy-kafka-cluster.bash; cd ${CWD}
cd deploy/vector-loki; ./deploy-vector-loki.bash; cd ${CWD}
cd deploy/platform-monitoring; ./deploy-platform-monitor.bash; cd ${CWD}

# Put this to the very end
cd deploy/certificates; ./deploy-certificates.bash; cd ${CWD}