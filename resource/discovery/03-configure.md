Before proceeding with the Resouce Discovery building block deployment, we need first to configure it. We can do it with the configuration script `configure-resource-discovery.sh` provided in the EOEPCA dployment guide.

```
bash configure-resource-discovery.sh
```{{exec}}

The script will start with the general EOEPCA configuration and move on sto the now the Resource Discovery building block specific configuration. We do not need to update domain and storage class, we will use what's already set:
```
no
no
```{{exec}}

There is currently a bug in the deployment configuration. Because of that we must replace a value in the generated config. This will not be necessary in the final version of EOEPCA, once the bug gets fixed.
```
sed -i -e 's/volume_storage_type/volume_storageclass/' generated-values.yaml
```{{exec}}
