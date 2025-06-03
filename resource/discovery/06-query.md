# Query the Catalogue

Run a STAC query to retrieve your dataset:

```bash
curl -X POST http://localhost:8082/stac/search \
  -H "Content-Type: application/json" \
  -d '{
    "bbox": [9.0, 44.0, 11.0, 46.0],
    "datetime": "2023-01-01T00:00:00Z/2023-12-31T23:59:59Z",
    "collections": ["demo-collection"]
  }'
```

Expected: the response includes your previously ingested item.
