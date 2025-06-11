Before proceeding with the Resouce Registration building block deployment, we need first to configure it. We can do it with the configuration script `configure-resource-registration.sh` provided in the EOEPCA dployment guide.

```
bash configure-resource-registration.sh
```{{exec}}

The script will start with the general EOEPCA configuration.

We have already set the ingress host (top level domain for our services) and the storage class, so we answer `no` to both questions
```
no
no
```{{exec}}

We set our Flowable credentials to `eoepca/eoepca`:
```
eoepca
eoepca
```{{exec}}
