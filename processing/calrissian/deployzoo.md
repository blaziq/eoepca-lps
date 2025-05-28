We can now deploy our processing building block.

The building block is deployed by deploying Zoo, which provides the OGC API Process interface.

Zoo will then deploy, on-demand when a new processing request is received, Calrissian, which will then deploy the application and execute the data processing job. 
 
To deploy Zoo, we first add the Zoo software helm repository

```
helm repo add zoo-project https://zoo-project.github.io/charts/
helm repo update zoo-project
```{{exec}}

then we deploy the software via helm, using the configuration values generated in the step before.

```
helm upgrade -i zoo-project-dru zoo-project/zoo-project-dru \
  --version 0.4.7 \
  --values generated-values.yaml \
  --namespace processing \
  --create-namespace
```{{exec}}

now, we need to wait the Zoo services to start.

This may take some time, expecially in this demo environment. To automatically wait for all the Zoo pods to be ready you can run

```
kubectl -n processing wait pod --all --timeout=10m --for=condition=Ready
```{{exec}}

once all the pods are in Ready status, our OGC API process interface is available

```
curl -s -S http://zoo.eoepca.local/ogc-api/processes/ | jq
```{{exec}}

if all went right, you should see an "echo" processing service available. This is a demo "empty" application.

We will add our own data processing application in the next step.
