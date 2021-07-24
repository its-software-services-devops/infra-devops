#/bin/bash

CFG=kubeconfig
terraform output its-rancher-demo-kube_config_yaml > ${CFG}.out

LINECOUNT=$(cat ${CFG}.out | wc -l)
let "TOLINE=${LINECOUNT}-1"
sed -ne "2,${TOLINE}p" ${CFG}.out > ${CFG}

export KUBECONFIG=$(pwd)/${CFG}

cd deploy/prometheus; ./deploy-prometheus-config.bash; cd ..
cd deploy/certificates; ./deploy-certificates.bash; cd ..

#./deploy-service-ingress.bash