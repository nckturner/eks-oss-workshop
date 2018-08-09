## Deploy the echo server and ingress

```
$ kubectl apply -f echoserver.yaml
service/echoserver created
deployment.extensions/echoserver created
```

```
$ kubectl get pods -n kube-system
NAME                                      READY     STATUS              RESTARTS   AGE
alb-ingress-controller-7975454957-jbmdn   1/1       Running             0          1m
aws-node-fkccv                            1/1       Running             1          8m
aws-node-mqptc                            1/1       Running             1          8m
default-http-backend-7ff44df5b7-f5ktf     1/1       Running             0          7m
echoserver-79fff955d7-4bgkq               1/1       Running             0          7s
echoserver-79fff955d7-jb6p6               0/1       ContainerCreating   0          7s
kube-dns-7cc87d595-gg8zn                  3/3       Running             0          14m
kube-proxy-bbg6d                          1/1       Running             0          8m
kube-proxy-rp2tv                          1/1       Running             0          8m
```

```
$ kubectl apply -f echoserver-ingress.yaml
```

## Check the log now

```
 I0809 21:53:19.142047       1 loadbalancer.go:265] kube-system/echoserver: Start ELBV2 creation.
 I0809 21:53:20.401836       1 loadbalancer.go:272] kube-system/echoserver: Completed ELBV2 creation. Name: 28dcb5c6-kubesystem-echose-d1ad | ARN: arn:aws:elasticloadbalancing:us-west-2:638386993804:loadbalancer/app/28dcb5c6-kubesystem-echose-d1ad/64a1b563ffcb7109
I0809 21:53:20.401852       1 targetgroup.go:226] kube-system/echoserver: Start TargetGroup creation.
I0809 21:53:20.402099       1 event.go:221] Event(v1.ObjectReference{Kind:"Ingress", Namespace:"kube-system", Name:"echoserver", UID:"a073dc72-9c1e-11e8-b0b9-06c32ed0ab7a", APIVersion:"extensions/v1beta1", ResourceVersion:"5793", FieldPath:""}): type: 'Normal' reason: 'CREATE' 28dcb5c6-kubesystem-echose-d1ad created
I0809 21:53:21.197778       1 targetgroup.go:231] kube-system/echoserver: Succeeded TargetGroup creation. ARN: arn:aws:elasticloadbalancing:us-west-2:638386993804:targetgroup/28dcb5c6-04e19804a28966d29ab/8f2f8537ffbbc463 | Name: 28dcb5c6-04e19804a28966d29ab.
I0809 21:53:21.197795       1 targetgroup.go:226] kube-system/echoserver: Start TargetGroup creation.
I0809 21:53:21.198024       1 event.go:221] Event(v1.ObjectReference{Kind:"Ingress", Namespace:"kube-system", Name:"echoserver", UID:"a073dc72-9c1e-11e8-b0b9-06c32ed0ab7a", APIVersion:"extensions/v1beta1", ResourceVersion:"5793", FieldPath:""}): type: 'Normal' reason: 'CREATE' 28dcb5c6-04e19804a28966d29ab target group created
I0809 21:53:21.742136       1 targetgroup.go:231] kube-system/echoserver: Succeeded TargetGroup creation. ARN: arn:aws:elasticloadbalancing:us-west-2:638386993804:targetgroup/28dcb5c6-04e19804a28966d29ab/8f2f8537ffbbc463 | Name: 28dcb5c6-04e19804a28966d29ab.
I0809 21:53:21.742156       1 listener.go:167] kube-system/echoserver: Start Listener creation.
I0809 21:53:21.742416       1 event.go:221] Event(v1.ObjectReference{Kind:"Ingress", Namespace:"kube-system", Name:"echoserver", UID:"a073dc72-9c1e-11e8-b0b9-06c32ed0ab7a", APIVersion:"extensions/v1beta1", ResourceVersion:"5793", FieldPath:""}): type: 'Normal' reason: 'CREATE' 28dcb5c6-04e19804a28966d29ab target group created
I0809 21:53:21.774721       1 listener.go:172] kube-system/echoserver: Completed Listener creation. ARN: arn:aws:elasticloadbalancing:us-west-2:638386993804:listener/app/28dcb5c6-kubesystem-echose-d1ad/64a1b563ffcb7109/2ac263437d59f96c | Port: 80 | Proto: HTTP.
I0809 21:53:21.774738       1 rule.go:125] kube-system/echoserver: Start Rule creation.
I0809 21:53:21.774919       1 event.go:221] Event(v1.ObjectReference{Kind:"Ingress", Namespace:"kube-system", Name:"echoserver", UID:"a073dc72-9c1e-11e8-b0b9-06c32ed0ab7a", APIVersion:"extensions/v1beta1", ResourceVersion:"5793", FieldPath:""}): type: 'Normal' reason: 'CREATE' 80 listener created
I0809 21:53:21.803202       1 rule.go:130] kube-system/echoserver: Completed Rule creation. Rule Priority: "1" | Condition: [{    Field: "path-pattern",    Values: ["/"]  }]
I0809 21:53:21.803417       1 event.go:221] Event(v1.ObjectReference{Kind:"Ingress", Namespace:"kube-system", Name:"echoserver", UID:"a073dc72-9c1e-11e8-b0b9-06c32ed0ab7a", APIVersion:"extensions/v1beta1", ResourceVersion:"5793", FieldPath:""}): type: 'Normal' reason: 'CREATE' 1 rule created
I0809 21:53:22.394366       1 loadbalancer.go:509] kube-system/echoserver: Modifying ELBV2 tags to [{    Key: "kubernetes.io/cluster/ferocious-outfit-1533847666",    Value: "owned"  },{    Key: "kubernetes.io/ingress-name",    Value: "echoserver"  },{    Key: "kubernetes.io/namespace",    Value: "kube-system"  }].
I0809 21:53:22.410185       1 event.go:221] Event(v1.ObjectReference{Kind:"Ingress", Namespace:"kube-system", Name:"echoserver", UID:"a073dc72-9c1e-11e8-b0b9-06c32ed0ab7a", APIVersion:"extensions/v1beta1", ResourceVersion:"5793", FieldPath:""}): type: 'Normal' reason: 'MODIFY' 28dcb5c6-kubesystem-echose-d1ad tags modified
```

## Get hostname of ALB

```
$ kubectl -n kube-system describe ingress echoserver
Name:             echoserver
Namespace:        kube-system
Address:          14b0b7b5-kubesystem-echose-d1ad-778100555.us-west-2.elb.amazonaws.com
...
```

Wait! It takes a while for everything to settle down in AWS and the address will not resolve until the ALB is available.

```
$ curl 14b0b7b5-kubesystem-echose-d1ad-778100555.us-west-2.elb.amazonaws.com
CLIENT VALUES:
client_address=192.168.209.120
command=GET
real path=/
query=nil
request_version=1.1
request_uri=http://14b0b7b5-kubesystem-echose-d1ad-778100555.us-west-2.elb.amazonaws.com:8080/

SERVER VALUES:
server_version=nginx: 1.10.0 - lua: 10001

HEADERS RECEIVED:
accept=*/*
host=14b0b7b5-kubesystem-echose-d1ad-778100555.us-west-2.elb.amazonaws.com
user-agent=curl/7.54.0
x-amzn-trace-id=Root=1-5b4cf835-e58bf47cf943ff361e6e5720
x-forwarded-for=107.184.224.246
x-forwarded-port=80
x-forwarded-proto=http
BODY:
-no body in request-
```
