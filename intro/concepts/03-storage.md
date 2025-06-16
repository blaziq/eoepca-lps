A HostPath provisioner is a type of volume that essentially uses the local disk space of nodes mounted inside pods. This is not something that should be used in production environments, for which EOEPCA Deployment Guide provides instructions to configure more suitable provisioners and storage classes. It is, however, ideally suitable for scenarios like development or for quick deployment and hence we are going to deploy it in this training and use it subsquently in Building Block trainings.

The configuration of the HostPath provisioner and its assosicated `standard` storage class is provided with the EOEPCA Deploment Guide:
```
kubectl apply -f https://raw.githubusercontent.com/EOEPCA/deployment-guide/refs/heads/main/docs/prerequisites/hostpath-provisioner.yaml
```{{exec}}

We can check if the provisioner has been deployed:
```
get -n kube-system sc/standard deploy/hostpath-storage-provisioner
```{{exec}}

Now, we can try to create a persistent volume claim (PVC) with ReadWriteMany access:
```
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-rwx-pvc
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
  storageClassName: standard
EOF
```{{exec}}

Check that the PVC created and in the status `Bound`:
```
kubectl get pvc
```{{exec}}

Finally, the test PVC can be deleted:
```
kubectl delete pvc/test-rwx-pvc
```{{exec}}
