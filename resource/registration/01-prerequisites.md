As ususal in this tutorial, we will use the EOEPCA Deployment Guide scripts to help us configuring and deploying our application. 

First, we clone it in our environment:
```
git clone https://github.com/EOEPCA/deployment-guide
```{{exec}}

The Rescource Registration Building Block deployment scripts are available in the `resource-registration` directory:
```
cd ~/deployment-guide/scripts/resource-registration
```{{exec}}

Next we'll check whether the prerequisites for installing the Resource Discovery building block are met. The Deployment Guide scripts provide a dedicated script for this task:
```
bash check-prerequisites.sh
```{{exec}}

This will ask a few questions about the Kubernetes cluster configuration and check if all the necessary prerequirements are installed. 



Now, since in our tutorial we decided not to use certficates, we can ignore the message:
> `Cert-Manager is not installed in the cluster.`
