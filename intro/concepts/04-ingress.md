Here we are going to deploy the nginx ingress controller. This is a simple alternative to the APISIX ingress controller which should be used in production environments. For details refer to the [relevant section of the EOEPCA Deployment Guide](https://eoepca.readthedocs.io/projects/deploy/en/latest/prerequisites/ingress/overview/).

First we add the nginx repository:
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```{{exec}}

Then we install nginx ingress controller from the repository:
```
helm upgrade -i ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx --create-namespace \
  --set controller.ingressClassResource.default=true \
  --set controller.allowSnippetAnnotations=true \
  --set controller.hostNetwork=true
```{{exec}}

We wait until the all pods in the `ingress-nginx` namespace are ready:
```
kubectl --namespace ingress-nginx wait pod --all --timeout=10m --for=condition=Ready
```{{exec}}

Let's create a test ingress for a non-existent service:
```
cat <<EOF | kubectl apply -f - 
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: test.eoepca.local
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx
  rules:
    - host: test.eoepca.local
      http:
        paths:
          - pathType: Prefix
            backend:
              service:
                name: test
                port:
                  number: 80
            path: /
EOF
```{{exec}}

Now we can check if our ingress works. We can do it by simply attempting to connect one of the services we have configured in DNS:
```
curl -s -S http://test.eoepca.local
```{{exec}}

It returns HTTP error `503 Service Temporarily Unavailable` but this is fine since we have not deployed any service the ingress could route the traffic to.

Finally, let's delete our sample ingress:
```
kubectl delete ingress test.eoepca.local
```{{exec}}
