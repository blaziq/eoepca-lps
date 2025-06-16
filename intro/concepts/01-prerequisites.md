First we obtain the Deployment Guide scripts:
```
git clone https://github.com/EOEPCA/deployment-guide
```{{exec}}

In the Deployment Guide scripts there is a special script for checking if the Kubernetes and infrastructure prerequisites are met. Let's run it now and see what's missing:
```
cd ~/deployment-guide/scripts/infra-prereq
bash check-prerequisites.sh
```{{exec}}

First, we must answer some questions, keeping in mind the configuration we are going to use - this will be explained in details in the next steps:
- HTTP scheme for the EOEPCA services
  ```
  http
  ```{{exec}}
- Nginx ingress controller
  ```
  nginx
  ```{{exec}}
- Base domain
  ```
  eoepca.local
  ```{{exec}}
- Kubernetes storage class for persistent volumes
  ```
  standard
  ```{{exec}}
- Automatic certificate issuance with cert-manager
  ```
  yes
  ```{{exec}}
- Cert Manager cluster issuer for TLS certificates
  ```
  eoepca-ca-clusterissuer
  ```{{exec}}
- `no` to the other two questions since these values are already set
  ```
  no
  no
  ```{{exec}}

--- 

From the results:
1. Pods can run as `root` - we will check that in details in one of our next steps
2. Could not reach ingress - ingress controller is not installed
3. No ClusterIssuer found - Cert-Manager is not deployed and configured
4. PVC did not bind with RWX - No ReadWriteMany storage class available for instantiating Persistent Volume Claims

Let's address these issues one by one.
