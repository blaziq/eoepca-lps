#!/bin/bash

# Installing Nginx Ingress (basic)
echo "Installing nginx ingress..." >> ${LOG}
helm upgrade --install ingress-nginx ingress-nginx \
    --repo https://kubernetes.github.io/ingress-nginx \
    --namespace ingress-nginx --create-namespace \
    --set controller.hostNetwork=true
