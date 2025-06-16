The Container Registry stores and distributes container images for application development and deployment. EOEPCA uses Harbor, an open-source container registry, to manage images for applications on the platform, including those from the Application Hub or running within the Processing building block.

Key features of Harbor include:
- Role-Based Access Control (RBAC): Control access to images based on user roles.
- Vulnerability Scanning: Detect vulnerabilities in images.
- Image Signing: Verify the authenticity of images.
- Audit Logs: Track operations for compliance.
- Replication: Sync images across multiple Harbor instances.

As usual, we will deploy Harbor using scripts provided in the EOEPCA Deployment Guide.

Let's check for prerequisites first. At this point all of them should be met:
```
cd ~/deployment-guide/scripts/container-registry
bash check-prerequisites.sh
```{{exec}}

Run the configuration script, answering `no` to all questions since these values are already set correctly:
```
bash configure-container-registry.sh
no
no
no
```{{exec}}

Now add the repository:
```
helm repo add harbor https://helm.goharbor.io
helm repo update harbor
```{{exec}}

And deploy Harbor into our Kubernetes cluster
```
helm upgrade -i harbor harbor/harbor \
  --version 1.7.3 \
  --values generated-values.yaml \
  --namespace harbor \
  --create-namespace
```{{exec}}

