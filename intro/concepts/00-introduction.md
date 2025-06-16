Welcome to the [Earth Observation Exploitation Platform Common Architecture](https://eoepca.org/eoepcaplus/) concepts and prerequisites tutorial.

In this tutorial we will follow the instructions from the EOEPCA deployment guide and use scripts included therein to set up building blocks and their dependencies.

As specified in the Deployment Guide, the following prerequisites are required or recommended to deploy and run EOEPCA building blocks:

1. **Kubernetes cluster**

   This is already provided by the Killercoda platform we are runnning the tutorial on.

2. **Wildcard DNS**

   For long-term deployments, a domain name and a wildcard DNS is required. This ensures that each EOEPCA building block can expose itself as service1.example.com, service2.example.com, etc.

   For the purpose of this training and subsequent trainings on individual Building Blocks, we have configured our testbed in a way that:
   - the domain names of our services are written to the `/etc/hosts` file
   - the  `coredns` service in our Kubernetes cluster has been reconfigured to use these local domains

3. **Storage**

   Some EOEPCA Building Blocks, particularly those involved in processing (e.g. the CWL Processing Engine), require shared storage with ReadWriteMany access. This allows to create volumens to which multiple pods can read and write concurrently.

   For the purpose of this training and subsequent training on individual Building Blocks (where required), we will configure the HostPath provisioner together with its associated `standard` storage class.

4. **Ingress controller**

   EOEPCA+ requires an ingress controller to route external traffic into the platform’s services. The ingress controller recommended by the EOEPCA Develpoment Guide is [APISIX](https://apisix.apache.org/) which is also mandatory if the EOEPCA's IAM (Identity and Access Management) is to be used. However, for other purposes such as a development instance or when a deployment is fully open or has its own authentication and authorization method, [NGINX](https://nginx.org/) ingress controller is supported.

   In the training we are going to deploy and use NGINX.

5. **Load Balancer**

   Typically, a load balancer provided with the cloud platform where EOEPCA is being installed, must be used and configured with the ingress controller to provide access to individual components.

   This is not going to be necessary in our trainings since we are using a very simplified Kubernetes configuration with only one node.
   
6. **Cert-Manager**

   Cert-Manager is an essential component for securing communication in EOEPCA, both internally between the component and externally with user clients. In EOEPCA it is typically configured with the LetsEncrypt ACME service (Automated Certificate Management Environment) and can autimatically issue, sign (by LetsEncrtypt) and renew TLS certificates. However, for cases when LetsEncrypt cannot be used there is an alternative method, and there is also a possibility not to install and use Cert-Manager at all in which case the traffic will not be encrypted.

   For the purpose of this training we will install Cert-Manager. However, to make things simple, in trainings on individual Building Blocks it will not be used.

7. **S3 Object storage**

   MinIO is a high-performance object storage system that’s compatible with the Amazon S3 API. In EOEPCA, MinIO can serve as the object storage backend for various services. There is also a possibility to configure an alternative S3-compatible object storage solution instead of MinIO e.g. use an external S3 storage provided by the cloud platform.

8. **Container Registry**

   The Container Registry stores and distributes container images for application development and deployment. EOEPCA uses Harbor, an open-source container registry, to manage images for applications on the platform, including those from the Application Hub or running within the Processing building block.


In the following steps we will deploy and configure the services **3, 4, 6, 7, 8** which are not already installed.
