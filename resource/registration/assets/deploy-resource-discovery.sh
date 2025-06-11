#!/bin/bash

pushd ~/deployment-guide/scripts/resource-discovery 
echo "--- Checking prerequisites"
bash check-prerequisites.sh

echo "--- Configuring Resource Discovery"
echo "nn" | bash configure-resource-discovery.sh

echo "--- Adding Helm repository"
helm repo add eoepca-dev https://eoepca.github.io/helm-charts-dev
helm repo update eoepca-dev

echo "--- Waiting for all deployments to be rolled out in ns gatekeeper-system"
kubectl --namespace gatekeeper-system wait deployment --all --for=condition=available --timeout=600s 

echo "--- Waiting for controller manager pods to be ready"
kubectl --namespace gatekeeper-system wait pod -l gatekeeper.sh/operation=webhook --for=condition=Ready --timeout=600s

echo "--- Deploying Resource Discovery Building Block"
helm upgrade -i resource-discovery eoepca-dev/rm-resource-catalogue \
  --values generated-values.yaml \
  --version 2.0.0-rc1 \
  --namespace resource-discovery \
  --create-namespace

echo "--- Waiting for Resouce Discovery pods to be ready"
kubectl --namespace resource-discovery wait pod --all --timeout=10m --for=condition=Ready

echo "--- Applying ingress"
kubectl apply -f generated-ingress.yaml

sleep 30

echo "--- Validating deployment"
bash validation.sh
popd
