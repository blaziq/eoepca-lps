Welcome to the **[EOEPCA Resource Registration](https://eoepca.readthedocs.io/projects/resource-registration/en/latest/)** building block tutorial!

The Resource Registration service enables data and metadata ingestion into platform services. It handles:
- Metadata registration into Resource Discovery
- Data registration into Data Access services
- Resource visualisation configuration

The Resource Registration Building Block manages resource ingestion into the platform for discovery, access and collaboration. It supports:
- Datasets (EO data, auxiliary data)
- Processing workflows
- Jupyter Notebooks
- Web services and applications
- Documentation and metadata

The Resource Registration BB comprises three main components:
1. Registration API
   
   An OGC API Processes interface for registering, updating, or deleting resources on the local platform.

2. Harvester
   
   Automates workflows to harvest data from external sources and register them in the platform.

3. Common Registration Library
   
   A Python library consolidating packages for business logic in workflows and resource handling.

---

### What Uou'll Learn
- Deploy Resource Registration Building Block on Kubernetes
- Validate and test the deployment
- Register a STAC-compliant collection into the catalogue
- Use the Registration Harvester to harvest data and register it into the catalogue

---

<!--
### Use Case

Imagine you've just ingested a new Sentinel-2 satellite scene into your system. To make it discoverable by other users or services, you publish the metadata into the Resource Catalogue using the STAC format.

Once published, other users can query it by:
- Region of interest (bounding box)
- Date range
- Data collection or mission

This tutorial simulates that workflow end-to-end.

---
-->

Let’s begin by making sure all required tools are installed.
