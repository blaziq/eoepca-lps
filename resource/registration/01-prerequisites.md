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

First, we choose th `http` scheme since we are not using certificates and encryption for our tutorial:
```
http
```{{exec}}

We choose the nginx ingress controller:
```
nginx
```{{exec}}

We enter the top-level domain for our EOEPCA services:
```
eoepca.local
```{{exec}}

We choose our storage class for persistent volumes:
```
standard
```{{exec}}

We also do not need automatically generated certificates or indeed any certificates at all for our tutorial:
```
no
```{{exec}}

Now, since in our tutorial we do not use certficates, we can ignore the message:
> Cert-Manager is not installed in the cluster.
> Please install Cert-Manager: https://cert-manager.io/docs/installation/
> If you are manually managing certificates, you can ignore this message.

As an extra prerequisite, we are going to install the Resource Discovery Building Block. Resource Registration is closely integrated and cooperates with it, and we will use it later on during our tutorial..

There is a prepared script which will deploy the Resource Discovery Building Block automatically. If you are interested in details about the deployment, please check our tutorial on Resource Discovery.
```
bash /tmp/assets/deploy-resource-discovery.sh
```{{exec}}
