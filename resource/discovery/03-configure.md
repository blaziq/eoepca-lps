### 3. Configure

Before proceeding with the Resouce Discovery building block deployment, we need first to configure it. We can do it with the configuration script `configure-resource-discovery.sh` provided in the EOEPCA dployment guide.

```
bash configure-resource-discovery.sh
```{{exec}}

The script will start with the general EOEPCA configuration.

For the demo deployment we are not generating certificates, so we will restrict ourselves to the http scheme.

```
http
```{{exec}}

We will use the nginx ingress controller in this tutorial.

```
nginx
```{{exec}}

As a domain, we use eoepca.local, which is mapped to the local machine in this demo.

```
eoepca.local
```{{exec}}

We set our storage class was already setup to 'standard' in the step before, so we do not need to update it,

```
no
```{{exec}}

We are not using automatic certificate generation and indeed no certificates at all, so again we answer 'no' to the next question.

```
no
```{{exec}}

We now move to the Processing Building Block specific configuration. We do not need to update domain and storage class, as we can use the standard ones.

```
no
no
```{{exec}}
