#!/bin/bash

# Prerequisites: readwritemany StorageClass
echo "Enabling ReadWriteMany StorageClass.."  >> ${1}
kubectl apply -f https://raw.githubusercontent.com/EOEPCA/deployment-guide/refs/heads/main/docs/prerequisites/hostpath-provisioner.yaml
echo 'export STORAGE_CLASS="standard"' >> ~/.eoepca/state
