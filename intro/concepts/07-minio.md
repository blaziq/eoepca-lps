MinIO is a high-performance object storage system that’s compatible with the Amazon S3 API. In EOEPCA, MinIO can serve as the object storage backend for various services. There is also a possibility to configure an alternative S3-compatible object storage solution instead of MinIO e.g. use an external S3 storage provided by the cloud platform.

As usual, we will use scripts provided with the EOEPCA Deployment Guide:
```
cd ~/deployment-guide/scripts/minio
```{{exec}}

First, we check prerequisited. At this point they should all be met:
```
bash check-prerequisites.sh
```{{exec}}

