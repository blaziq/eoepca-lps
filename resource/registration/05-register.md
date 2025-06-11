Now we are going to register a sample STAC Collection, following the example from the Deployment Guide. 

In order to do that, we execute the process `register`, already existing in the Resource Registration service, with parameters indication collection metadata. A link to the Resource Catalogue where the collection has been registered, is returned in the output.
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

We can verify the status of the registration job
```
curl -s http://registration-api.eoepca.local/jobs | jq
```{{exec}}


```
curl -s http://resource-catalogue.eoepca.local/collections/metadata:main/items/S2MSI2A
```{{exec}}

