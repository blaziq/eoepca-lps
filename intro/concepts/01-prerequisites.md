As specified in the deployment guide, the following prerequisites are required or recommended to deploy and run EOEPCA building blocks:

1. **Kubernetes cluster**

   This is already provided by the Killercoda platform we are runnning the tutorial on.

2. **Wildcard DNS**

   For long-term deployments, a domain name and a wildcard DNS is required. This ensures that each EOEPCA building block can expose itself as service1.example.com, service2.example.com, etc.

   For the purpose of the training, we have put the domain names of our services in the /etc/hosts file. The  `coredns` service in our Kubernetes cluster has also been configured to use these local domains.

3. **Storage**


4. **Ingress controller**

   The ingress controller recommended by the EOEPCA Develpoment Guide is [APISIX](https://apisix.apache.org/) which is also mandatory if the EOEPCA's IAM (Identity and Access Management) is to be used. However, for other purposes such as a development instance or when a deployment is fully open or has its own authentication and authorization method, [NGINX](https://nginx.org/) ingress controller is supported.

   In the training we are going to deploy and use NGINX.

5. **Load Balancer**

6. **Cert-Manager**

7. **S3 Object storage**

8. **Container Registry**

In the following steps we will deploy and configure the services 3-8 which are not already installed.

