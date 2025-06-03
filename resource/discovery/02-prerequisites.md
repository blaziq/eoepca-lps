### 2. Prerequisites

As ususal in this tutorial, we will use the EOEPCA Deployment Guide scripts to help us configuring and deploying our application. 

First, we clone it in our environment:

```
git clone https://github.com/EOEPCA/deployment-guide
```{{exec}}

The Rescource Catalogue deployment scripts are available in the `resource-discovery` directory:

```
cd ~/deployment-guide/scripts/resource-discovery
git checkout killercoda-demo
```{{exec}}

Next we'll check whether the prerequisites for installing the Resource Discovery building block are met. The Deployment Guide scripts provide a dedicated script for this task:

```
bash check-prerequisites.sh
```{{exec}}

Since in our tutorial we are using unencrypted communication and no certficates, we can ignore the message 

> `Cert-Manager is not installed in the cluster.`

<!--
As specified in the deployment guide, the OGC API Process interface, Calrissian Kubernetes engine, requires the following pre-requisites:
 - a kubernetes cluster
 - a Read-Write-Many Storage Class (a pre-requisite for both Zoo and Calrissian)
 - an S3 object storage

we will check in the next steps the avaliability of these pre-requisites
-->
