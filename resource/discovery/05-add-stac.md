Let’s register some sample datasets in the Resource Catalogue. We will use two methods of doing that:
- STAC API
- PyCSW admin script

1. Add STAC Metadata via STAC API

We will create a file with simple JSON metadata first:
```
cat <<EOF > item.json
{
  "type": "Feature",
  "stac_version": "1.0.0",
  "id": "sample-dataset",
  "properties": {
    "datetime": "2023-12-01T00:00:00Z"
  },
  "geometry": {
    "type": "Point",
    "coordinates": [10.0, 45.0]
  },
  "links": [],
  "assets": {},
  "collection": "demo-collection"
}
EOF

```{{exec}}

And then we will ingest the item to the catalague using the STAC API endpoint:

```
curl -X POST http://resource-catalogue.eoepca.local/stac/collections/demo-collection/items \
  -H "Content-Type: application/json" \
  -d @item.json
```{{exec}}

2. Now we will inject another dataset with the PyCSW admin script, as described in the EOEPCA Deployment Guide.

First, we need to identify the Resource Discovery service pod and copy the sample file `sample_record.xml` already provided with the Deployment Guide scripts into the pod:
```
RESOURCE_CATALOGUE_POD=`kubectl -n resource-discovery get pods --no-headers -o custom-columns=NAME:.metadata.name | grep resource-catalogue-service`
kubectl -n resource-discovery cp sample_record.xml ${RESOURCE_CATALOGUE_POD}:/tmp/
```{{exec}}

Then, we need to run the `pycsw-admin.py` script inside the pod, pointing it to the copied file as source:
```
kubectl -n resource-discovery exec -it ${RESOURCE_CATALOGUE_POD} -- /usr/local/bin/pycsw-admin.py load-records --config /etc/pycsw/pycsw.yml --path /tmp/sample_record.xml
```{{exec}}
