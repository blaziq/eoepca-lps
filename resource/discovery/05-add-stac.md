# Add STAC Metadata

Let’s register a sample dataset in the Resource Catalogue.

## 1. Create a file named `item.json`:

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

## 2. Ingest the item

```
curl -X POST http://resource-catalogue.eoepca.local/stac/collections/demo-collection/items \
  -H "Content-Type: application/json" \
  -d @item.json
```{{exec}}
