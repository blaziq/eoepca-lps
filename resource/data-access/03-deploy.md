```
helm repo add eoapi https://devseed.com/eoapi-k8s/
helm repo update eoapi
```{{exec}}

```
helm upgrade -i eoapi eoapi/eoapi \
  --namespace data-access \
  --create-namespace \
  --values eoapi/generated-values.yaml
```{{exec}}

```
helm repo add eoepca-dev https://eoepca.github.io/helm-charts-dev
helm repo update eoepca-dev
```{{exec}}

```
helm upgrade -i stac-manager eoepca-dev/stac-manager \
  --namespace data-access \
  --values stac-manager/generated-values.yaml
```{{exec}}

```
helm upgrade -i eoapi-maps-plugin eoepca-dev/eoapi-maps-plugin \
  --namespace data-access \
  --values eoapi-maps-plugin/generated-values.yaml
```{{exec}}


[STAC Browser]({{TRAFFIC_HOST1_81}})

[Maps]({{TRAFFIC_HOST1_82}})


