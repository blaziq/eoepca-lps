As ususal in this tutorial, we will use the EOEPCA deployment-guide scripts to help us configuring and deploying our application. Let's clone it in our environment

```
git clone https://github.com/EOEPCA/deployment-guide
```{{exec}}

the OGC API Process interface deployment scripts are available in the `resource-discovery` directory, let's open it

```
cd ~/deployment-guide/scripts/resource-discovery
git checkout killercoda-demo
```{{exec}}

We will check whether the prerequisites for installing the Resource Discovery building block are met:
```
bash check-prerequisites.sh
```{{exec}}



As specified in the deployment guide, the OGC API Process interface, Calrissian Kubernetes engine, requires the following pre-requisites:
 - a kubernetes cluster
 - a Read-Write-Many Storage Class (a pre-requisite for both Zoo and Calrissian)
 - an S3 object storage

we will check in the next steps the avaliability of these pre-requisites
