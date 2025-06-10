In the previous step we registered two items in the catalogue. Let's verify first if we actually have the two items. For this, we will run a STAC search without any parameters and extract the total number of returned results:
```
curl -s -X POST http://resource-catalogue.eoepca.local/stac/search | jq ".numberReturned"
```{{exec}}


We run a STAC query to retrieve the dataset inserted using the STAC API:
```bash
curl -X POST http://resource-catalogue.eoepca.local/stac/search \
  -H "Content-Type: application/json" \
  -d '{
    "bbox": [9.0, 44.0, 11.0, 46.0],
    "datetime": "2023-01-01T00:00:00Z/2023-12-31T23:59:59Z",
    "collections": ["demo-collection"]
  }' | jq
```{{exec}}

The repsonse includes our previously registered item.

Now we run another STAC query to retrieve the item inserted with the PyCSW admin script and the sample XML file. Because it has neither bbox nor datetime, we will use STAC API free search and query for the item title, which was `EOEPCA Sample Record`:
```
curl -X POST http://resource-catalogue.eoepca.local/stac/search?q=EOEPCA   -H "Content-Type: application/json"   -d '{ "q": "EOEPCA Sample Record", "collections": ["metadata\:main"] }'  | jq
```{{exec}}

Again, the response includes our registered item from the `sample_record.xml` file.
