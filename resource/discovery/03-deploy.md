# Deploy Resource Catalogue

## Kubernetes (via Helm)

```bash
helm repo add eoepca https://eoepca.github.io/helm-charts
helm repo update

helm install resource-catalogue eoepca/resource-catalogue \
  --namespace resource-discovery \
  --create-namespace
```

## Docker Compose

```bash
git clone https://github.com/EOEPCA/eoepca-resource-catalogue.git
cd eoepca-resource-catalogue
docker-compose up -d
```

Once deployed, the STAC API should be accessible at:
```
http://localhost:8082/stac
```
