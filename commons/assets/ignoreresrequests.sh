#!/bin/bash

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
