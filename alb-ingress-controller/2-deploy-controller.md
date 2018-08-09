## Apply rbac-role.yaml

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
_ AWS_REGION
_ CLUSTER\*NAME

- AWS\*ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

```
$ kubectl apply -f alb-mine.yaml
deployment.extensions/alb-ingress-controller created
```

## Tail the log

```
$ kubectl logs -f -n kube-system `kubectl get po -n kube-system | egrep -o alb-ingress[a-zA-Z0-9-]+`
-------------------------------------------------------------------------------
AWS ALB Ingress controller
  Release:    1.0-beta.5
  Build:      git-9f321d0e
  Repository: https://github.com/kubernetes-sigs/aws-alb-ingress-controller
-------------------------------------------------------------------------------

I0809 21:13:10.738321       1 flags.go:131] Watching for Ingress class: alb
W0809 21:13:10.738460       1 client_config.go:552] Neither --kubeconfig nor --master was specified.  Using the inClusterConfig.  This might not work.
I0809 21:13:10.738623       1 main.go:159] Creating API client for https://10.100.0.1:443
I0809 21:13:10.755924       1 main.go:203] Running in Kubernetes cluster version v1.10 (v1.10.3) - git (clean) commit 2bba0127d85d5a46ab4b778548be28623b32d0b0 - platform linux/amd64
I0809 21:13:10.756496       1 alb.go:85] ALB resource names will be prefixed with 28dcb5c6
I0809 21:13:10.766407       1 alb.go:158] Starting AWS ALB Ingress controller
I0809 21:13:11.967395       1 leaderelection.go:185] attempting to acquire leader lease  kube-system/ingress-controller-leader-alb...
I0809 21:13:11.971789       1 status.go:152] new leader elected: alb-ingress-controller-6d5445d56f-4zr8h
I0809 21:13:12.396700       1 albingresses.go:67] Building list of existing ALBs
I0809 21:13:12.434621       1 albingresses.go:75] Fetching information on 0 ALBs
I0809 21:13:12.447051       1 albingresses.go:91] Assembled 0 ingresses from existing AWS resources in 50.336061ms
```
