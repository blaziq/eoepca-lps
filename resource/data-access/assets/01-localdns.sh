#!/bin/bash

#DNS-es for dependencies
echo "Setting local dns..." >> ${LOG}
IP=`hostname -I | cut -f1 -d' '`
WEBSITES=
while read port host; do
    WEBSITES="${WEBSITES} ${host}"
done < /tmp/assets/hosts

echo "${IP} ${WEBSITES}" >> /etc/hosts

kubectl get -n kube-system configmap/coredns -o yaml > kc.yml
sed -i "s|ready|ready\n        hosts {\n          ${IP} $WEBSITES\n          fallthrough\n        }|" kc.yml
kubectl apply -f kc.yml && rm kc.yml && kubectl rollout restart -n kube-system deployment/coredns
