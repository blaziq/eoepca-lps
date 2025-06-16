The Container Registry stores and distributes container images for application development and deployment. EOEPCA uses Harbor, an open-source container registry, to manage images for applications on the platform, including those from the Application Hub or running within the Processing building block.

Key features of Harbor include:
- Role-Based Access Control (RBAC): Control access to images based on user roles.
- Vulnerability Scanning: Detect vulnerabilities in images.
- Image Signing: Verify the authenticity of images.
- Audit Logs: Track operations for compliance.
- Replication: Sync images across multiple Harbor instances.

As usual, we will deploy Harbor using scripts provided in the EOEPCA Deployment Guide.

Let's check for prerequisites first.
```
cd deployment-guide/scripts/container-registry
bash check-prerequisites.sh
```{{exec}}
