We can now deploy the Resouce Registration Building Block. 

First must add the software helm repository.

```
helm repo add eoepca-dev https://eoepca.github.io/helm-charts-dev
helm repo update eoepca-dev
```{{exec}}

Then we deploy the software via helm, using the configuration values generated in the previous step.

```
helm upgrade -i registration-api eoepca-dev/registration-api \
  --version 2.0.0-rc1 \
  --namespace resource-registration \
  --create-namespace \
  --values registration-api/generated-values.yaml
```{{exec}} 

We will create ingress for our newly created Resource Discovery service to make it available. We use the configuration file generated automatically in the previous step.
```
kubectl apply -f registration-api/generated-ingress.yaml
```{{exec}}

```
helm repo add flowable https://flowable.github.io/helm/
helm repo update flowable
```{{exec}}

```
helm upgrade -i registration-harvester-api-engine flowable/flowable \
  --version 7.0.0 \
  --namespace resource-registration \
  --create-namespace \
  --values registration-harvester/generated-values.yaml
```{{exec}}

We will create ingress for our newly created Resource Discovery service to make it available. We use the configuration file generated automatically in the previous step.
```
kubectl apply -f registration-harvester/generated-ingress.yaml
```{{exec}}

```
helm upgrade -i registration-harvester-worker eoepca-dev/registration-harvester \
  --version 2.0.0-rc1 \
  --namespace resource-registration \
  --create-namespace \
  --values registration-harvester/generated-values.yaml
```{{exec}}

Now we wait for the Resource Discovery pods to start. This may take some time, expecially in this demo environment. To automatically wait for all service to be ready you can run:
```
kubectl --namespace resource-registration wait pod --all --timeout=10m --for=condition=Ready
```{{exec}}

We can validate our deployment with the provided script `validation.sh`
```
bash validation.sh
```{{exec}}
