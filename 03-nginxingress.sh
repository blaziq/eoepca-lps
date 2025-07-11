#!/bin/bash

# Installing Nginx Ingress (basic)
echo "Installing nginx ingress..." >> ${LOG}
helm upgrade --install ingress-nginx ingress-nginx \
    --repo https://kubernetes.github.io/ingress-nginx \
    --namespace ingress-nginx --create-namespace \
    --set controller.hostNetwork=true

if [[ "$0" == *"-nohttps.sh" ]]; then
    kubectl -n ingress-nginx patch service ingress-nginx-controller \
    --type='json' \
    -p='[{"op": "replace", "path": "/spec/ports/1/targetPort", "value":"http"}]'
fi
