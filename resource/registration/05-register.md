```
curl -s -X POST "http://registration-api.eoepca.local/processes/register/execution" \
  -H "Content-Type: application/json" \
  -d '{
    "inputs": {
        "type": "collection",
        "source": {"rel": "collection", "href": "https://raw.githubusercontent.com/james-hinton/temp-data-store/refs/heads/main/stac-collection.json"},
        "target": {"rel": "https://api.stacspec.org/v1.0.0/core", "href": "http://resource-catalogue.eoepca.local/stac"}
    }
  }' | jq
```{{exec}}

```
curl -s http://registration-api.eoepca.local/jobs
``` {{exec}}

```
curl -s http://resource-catalogue.eoepca.local/collections/metadata:main/items/S2MSI2A
```{{exec}}

