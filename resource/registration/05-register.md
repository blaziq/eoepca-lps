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


source ~/.eoepca/state

curl -s -u ${FLOWABLE_ADMIN_USER}:${FLOWABLE_ADMIN_PASSWORD} http://registration-harvester-api.eoepca.local/flowable-rest/service/repository/deployments | jq

files=(
  "https://raw.githubusercontent.com/EOEPCA/registration-harvester/refs/heads/main/workflows/landsat.bpmn"
  "https://raw.githubusercontent.com/EOEPCA/registration-harvester/refs/heads/main/workflows/landsat-scene-ingestion.bpmn"
)

for url in "${files[@]}"; do
  filename=$(basename "$url")
  curl -s -O "$url" # pobierz plik
  curl -s -X POST -u ${FLOWABLE_ADMIN_USER}:${FLOWABLE_ADMIN_PASSWORD} "http://registration-harvester-api.eoepca.local/flowable-rest/service/repository/deployments" \
    -F "file=@$filename" | jq
done


```
curl -s -u ${FLOWABLE_ADMIN_USER}:${FLOWABLE_ADMIN_PASSWORD} "http://registration-harvester-api.eoepca.local/flowable-rest/service/repository/process-definitions" | jq
```{{exec}}

```
PROCESS=$(curl -s -u ${FLOWABLE_ADMIN_USER}:${FLOWABLE_ADMIN_PASSWORD} "http://registration-harvester-api.eoepca.local/flowable-rest/service/repository/process-definitions" | jq -r '[.data.[] | select (.key=="landsatRegistration")] | max_by(.version) | .id ')
echo $PROCESS
```{{exec}}

```
PAYLOAD=$(cat <<EOF
{
  "processDefinitionId": "${PROCESS}",
  "variables": [
    {
      "name": "datetime_interval",
      "type": "string",
      "value": "2024-11-12T15:00:00.000000Z/2024-11-12T16:00:00.000000Z"
    },
    {
      "name": "collections",
      "type": "string",
      "value": "landsat-c2l2-sr"
    },
    {
      "name": "bbox",
      "type": "string",
      "value": "8,40,18,60"
    },
    {
      "name": "query",
      "type": "string",
      "value": "{\"created\": {\"gte\": \"2024-12-13T15:00:00.000000Z\", \"lt\": \"2024-12-13T16:00:00.000000Z\"}}"
    }
  ]
}
EOF
)
```{{exec}}

```
curl -s -X POST -u ${FLOWABLE_ADMIN_USER}:${FLOWABLE_ADMIN_PASSWORD} http://registration-harvester-api.eoepca.local/flowable-rest/service/runtime/process-instances \
  -H "Content-Type: application/json" \
  -d "${PAYLOAD]"| jq
```{{exec}}  
  
```  
curl -s -u ${FLOWABLE_ADMIN_USER}:${FLOWABLE_ADMIN_PASSWORD} http://registration-harvester-api.eoepca.local/flowable-rest/service/runtime/process-instances | jq
```{{exec}}

