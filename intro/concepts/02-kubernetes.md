For the Kubernetes cluster itself there is one strong requirement: pods must be able to run as root. This is required by certain EOEPCA components. 

In typical production environments this is defined by cluster's security policies. Here, we are simply going to check whether in our cluster provided by the KillerCoda platform a pod with root privileges can be created:
```
cat <<EOF | kubectl apply -f - 
apiVersion: v1
kind: Pod
metadata:
  name: root-check
spec:
  containers:
    - name: busybox
      image: busybox
      command: ["sleep", "3600"]
      securityContext:
        allowPrivilegeEscalation: false
        runAsUser: 0
  restartPolicy: Never
EOF
```{{exec}}

We wait until our `root-check` pod is ready:
```
kubectl wait pod root-check --timeout=10m --for=condition=Ready
```{{exec}}

We check whether it is running as root:
```
kubectl exec -it root-check -- id -un
```{{exec}}

If the output is `root`, it is confirmed that our pod is running with root privileges.

Now we can delete the pod:
```
kubectl delete pod root-check
```{{exec}}
