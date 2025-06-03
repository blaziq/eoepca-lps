#!/bin/bash
# Script to set pre-requisites for EOEPCA components

echo "Setting-up your environment... wait till this setup terminates before starting the tutorial" >> /tmp/killercoda_setup.log
LOG="/tmp/killercoda_setup.log"

if [[ -e /tmp/assets/localdns ]]; then
  # DNS-es for dependencies
  echo "Setting local DNS..." >> ${LOG}

  # Set local hosts file
  IP=`hostname -I | cut -f1 -d' '`
  DOMAIN="eoepca.local"
  SERVICES="minio minio-console zoo resource-discovery registration-api"
  WEBSITES="${DOMAIN} toil-wes.hpc.local `echo ${SERVICES} | sed -e "s/ \|$/.${DOMAIN} /g"`"
  echo "${IP} ${WEBSITES}" >> /etc/hosts

  # Update CoreDNS config map in Kubernetes
  kubectl get -n kube-system configmap/coredns -o yaml > kc.yml
  sed -i "s|ready|ready\n        hosts {\n          ${IP} ${WEBSITES}\n          fallthrough\n        }|" kc.yml
  kubectl apply -f kc.yml 
  rm kc.yml
  kubectl rollout restart -n kube-system deployment/coredns
fi

if [[ -e /tmp/assets/gomplate.7z ]]; then
  # Gomplate is a dependency of the deployment tool
  # Installing it from local instead then remote for speed
  # curl -s -S -L -o /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v4.3.0/gomplate_linux-amd64 && chmod +x /usr/local/bin/gomplate
  echo "Installing gomplate..." >> ${LOG}
  mkdir -p /usr/local/bin/ 
  7z x /tmp/assets/gomplate.7z -o/usr/local/bin/
  chmod +x /usr/local/bin/gomplate
fi

if [[ -e /tmp/assets/nginxingress ]]; then
  # Installing nginx ingress controller (basic)
  echo "Installing nginx ingress controller..." >> ${LOG}
  helm upgrade --install ingress-nginx ingress-nginx \
    --repo https://kubernetes.github.io/ingress-nginx \
    --namespace ingress-nginx --create-namespace \
    --set controller.ingressClassResource.default=true \
    --set controller.allowSnippetAnnotations=true \
    --set controller.service.type=LoadBalancer \
    --set controller.hostNetwork=true
fi

if [[ -e /tmp/assets/minio.7z ]]; then
  # Installing Minio S3 storage (basic)
  echo "Installing Minio S3 object storage..." >> ${LOG}
  # Prerequisite: minio
  # We have this locally installed for speed
  # wget -q https://dl.min.io/server/minio/release/linux-amd64/minio -O /usr/local/bin/minio && chmod +x /usr/local/bin/minio
  # wget -q https://dl.min.io/client/mc/release/linux-amd64/mc -O  /usr/local/bin/mc && chmod +x /usr/local/bin/mc
  mkdir -p /usr/local/bin/ && 7z x /tmp/assets/minio.7z -o/usr/local/bin/ && chmod +x /usr/local/bin/mc /usr/local/bin/minio
  mkdir -p ~/minio && MINIO_ROOT_USER=eoepca MINIO_ROOT_PASSWORD=eoepcatest nohup minio server --quiet ~/minio &>/dev/null &
  sleep 1
  while ! mc config host add minio-local http://minio.eoepca.local:9000/ eoepca eoepcatest; do sleep 1; done
  # mc alias set minio-local http://minio.eoepca.local:9000/ eoepca eoepcatest
  mc mb minio-local/eoepca
  mkdir -p ~/.eoepca && echo 'export S3_ENDPOINT="http://minio.eoepca.local:9000/"
export S3_ACCESS_KEY="eoepca" 
export S3_SECRET_KEY="eoepcatest"
export S3_REGION="us-east-1"' >> ~/.eoepca/state
fi

if [[ -e /tmp/assets/readwritemany ]]; then
  ### Prerequisites: readwritemany StorageClass
  echo "Enabling ReadWriteMany StorageClass.."  >> ${LOG}
  kubectl apply -f https://raw.githubusercontent.com/EOEPCA/deployment-guide/refs/heads/main/docs/prerequisites/hostpath-provisioner.yaml
  echo 'export STORAGE_CLASS="standard"'>>~/.eoepca/state
fi

if [[ -e /tmp/assets/ignoreresrequests ]]; then
  ### Avoid applyiing resource limits, otherwise Clarissian will not work as limits are hardcoded in there...
  ### THIS IS JUST FOR DEMO! DO NOT DO THIS PART IN PRODUCTION!
  echo "Setting resource limits..."  >> ${LOG}
  kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/v3.18.2/deploy/gatekeeper.yaml
  cat <<EOF | kubectl apply -f -
apiVersion: mutations.gatekeeper.sh/v1
kind: Assign
metadata:
  name: relieve-resource-pods
spec:
  applyTo:
  - groups: [""]
    kinds: ["Pod"]
    versions: ["v1"]
  match:
    scope: Namespaced
    kinds:
      - apiGroups: [ "*" ]
        kinds: [ "Pod" ]
  location: "spec.containers[name:*].resources.requests"
  parameters:
    assign:
      value:
        cpu: "0"
        memory: "0"
---
apiVersion: mutations.gatekeeper.sh/v1
kind: Assign
metadata:
  name: relieve-resource-inits
spec:
  applyTo:
  - groups: [""]
    kinds: ["Pod"]
    versions: ["v1"]
  match:
    scope: Namespaced
    kinds:
      - apiGroups: [ "*" ]
        kinds: [ "Pod" ]
  location: "spec.initContainers[name:*].resources.requests"
  parameters:
    assign:
      value:
        cpu: "0"
        memory: "0"
EOF
fi

if [[ -e /tmp/assets/pythonvenv ]]; then
  # Enable Pyton virtual environments
  echo "Enabling Python virtual environments..." >> ${LOG}
  [[ -e /tmp/apt-is-updated ]] || { apt update -y; touch /tmp/apt-is-updated; }
  apt install -y python3.12-venv
fi

if [[ -e /tmp/assets/htcondor ]]; then
  echo "Installing HPC batch system for ubuntu user..." >> ${LOG}
  [[ -e /tmp/apt-is-updated ]] || { apt update -y; touch /tmp/apt-is-updated; }
  apt install -y minicondor </dev/null
  # Allow ubuntu user to submit jobs
  usermod -a -G docker ubuntu
  # Mount the local /etc/hosts in docker for the DNS resolution
  echo '#!/usr/bin/python
import sys, os
n=sys.argv
n[0]="/usr/bin/docker"
if "run" in n: n.insert(n.index("run")+1,"-v=/etc/hosts:/etc/hosts:ro")
os.execv(n[0],n)' > /usr/local/bin/docker
  chmod +x /usr/local/bin/docker
fi

if [[ -e /tmp/assets/xmltools ]]; then
  # Install XML utils for parsing output from service endpoint
  echo "Installing XML Utils..." >> ${LOG}
  [[ -e /tmp/apt-is-updated ]] || { apt update -y; touch /tmp/apt-is-updated; }
  apt install -y libxml2-utils
fi

#Stop the foreground script (we may finish our script before tail starts in the foreground, so we need to wait for it to start if it does not exist)
while ! killall tail; do sleep 1; done
