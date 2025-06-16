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

We wait until the all pods in the `harbor` namespace are ready:
```
kubectl --namespace harbor wait pod --all --timeout=10m --for=condition=Ready
```{{exec}}

We can now run the script `validation.sh` to see if our Harbor deployment works fine:
```
bash validation.sh
```{{exec}}

Again, since we do not have web browser access to our Harbor instance, we will use a combination of command line tools to perform some operations on Harbor:
- create a project
- push and pull images
- list the content of repositories

For this, we need the Harbor CLI tool [`harbor`](https://github.com/goharbor/harbor-cli). We also need to reconfigure Docker so that it trusts our Harbor registry which otherwise doesn't have a valid certificate. Both requirements have already been installed and/or configured and both are not really necessary in a production environment where Harbor is supposed to have a signed valid TLS certificate.

First we must login to our Harbor registry from Docker:
```
source ~/.eoepca/state
docker login -u admin -p "${HARBOR_ADMIN_PASSWORD}" harbor.eoepca.local
```{{exec}}

We pull an image from DockerHub, tag it and push it to Harbor. Typically, local images created by users will be stored that way.
```
docker pull alpine:latest
docker tag alpine:latest harbor.eoepca.local/library/alpine:latest
docker push harbor.eoepca.local/library/alpine:latest
```{{exec}}

Now we delete the local images:
```
docker image rm alpine:latest
docker image rm harbor.eoepca.local/library/alpine:latest
```{{exec}}



