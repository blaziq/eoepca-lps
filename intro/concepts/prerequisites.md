In this tutorial we will follow the instructions from the EOEPCA deployment guide and use scripts included therein to set up building blocks and their dependencies.

Here's how we obtain the deployment scripts:
```
git clone https://github.com/EOEPCA/deployment-guide
git checkout killercoda-demo
```
{{exec}}

As specified in the deployment guide, the following prerequisites are required or recommended to deploy and run EOEPCA building blocks:
1. **Kubernetes cluster**

   This is already provided by the Killercoda platform we are runnning the tutorial on.

2. **Ingress controller**

   The recommended controller is [APISIX](https://apisix.apache.org/) which is also required if the EOEPCA's IAM (Identity and Access Management) is to be used. For other purposes such as when a deployment is fully open or an own authorization method is used, [NGINX](https://nginx.org/) is supported.

   In the training we are going to deploy and use NGINX.

3. **Wildcard DNS**

   For long-term deployments, a domain name and a wildcard DNS is required. This ensures that each EOEPCA building block can expose itself as service1.example.com, service2.example.com, etc.

   For the purpose of the training, we put the domain names of our services in the /etc/hosts file.

4. **Load Balancer**

5. **Cert-Manager**

6. **Storage**

7. **S3 Object storage**

8. **Container Registry**

In the following steps we will install 

