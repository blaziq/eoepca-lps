#!/bin/bash

pushd ~/deployment-guide/scripts/resource-discovery 
bash check-prerequisites.sh
echo "nn" | bash configure-resource-discovery.sh
helm repo add eoepca-dev https://eoepca.github.io/helm-charts-dev
helm repo update eoepca-dev
sleep 30 
helm upgrade -i resource-discovery eoepca-dev/rm-resource-catalogue \
  --values generated-values.yaml \
  --version 2.0.0-rc1 \
  --namespace resource-discovery \
  --create-namespace
kubectl --namespace resource-discovery wait pod --all --timeout=10m --for=condition=Ready
kubectl apply -f generated-ingress.yaml
sleep 30
bash validation.sh
popd
