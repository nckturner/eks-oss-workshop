## Apply default-backend.yaml & rbac-role.yaml
```
$ kubectl apply -f default-backend.yaml
deployment.extensions/default-http-backend created
service/default-http-backend created
```
```
$ kubectl apply -f rbac-role.yaml
clusterrole.rbac.authorization.k8s.io/alb-ingress-controller created
clusterrolebinding.rbac.authorization.k8s.io/alb-ingress-controller created
serviceaccount/alb-ingress created
```

## Deploy the controller

```
$ cp alb-ingress-controller-template.yaml alb-mine.yaml
```

Modify these fields in the `alb-mine.yaml`
	* AWS_REGION
	* CLUSTER_NAME
	* AWS_ACCESS_KEY_ID
	* AWS_SECRET_ACCESS_KEY

```
$ kubectl apply -f alb-mine.yaml
deployment.extensions/alb-ingress-controller created
```


## Tail the log
```
$ kubectl logs -f -n kube-system `kubectl get po -n kube-system | egrep -o alb-ingress[a-zA-Z0-9-]+` | egrep -o '\[ALB-INGRESS.*$'
[ALB-INGRESS] [controller] [INFO]: Log level read as "", defaulting to INFO. To change, set LOG_LEVEL environment variable to WARN, ERROR, or DEBUG.
[ALB-INGRESS] [controller] [INFO]: Ingress class set to alb
[ALB-INGRESS] [controller] [INFO]: albNamePrefix undefined, defaulting to 14b0b7b5
[ALB-INGRESS] [ingress] [INFO]: Building list of existing ALBs
[ALB-INGRESS] [ingress] [INFO]: Fetching information on 0 ALBs
[ALB-INGRESS] [ingress] [INFO]: Assembled 0 ingresses from existing AWS resources in 64.00002ms
```

