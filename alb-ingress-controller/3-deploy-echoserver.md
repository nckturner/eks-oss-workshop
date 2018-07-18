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
$ kubectl apply -f ingress.yaml
ingress.extensions/echoserver created
```

## Check the log now
```
[ALB-INGRESS] [kube-system/echoserver] [INFO]: Start ELBV2 creation.
[ALB-INGRESS] [kube-system/echoserver] [INFO]: Completed ELBV2 creation. Name: 14b0b7b5-kubesystem-echose-d1ad | ARN: arn:aws:elasticloadbalancing:us-west-2:638386993804:loadbalancer/app/14b0b7b5-kubesystem-echose-d1ad/8d78772a9d7a1a10
[ALB-INGRESS] [kube-system/echoserver] [INFO]: Start TargetGroup creation.
[ALB-INGRESS] [kube-system/echoserver] [INFO]: Succeeded TargetGroup creation. ARN: arn:aws:elasticloadbalancing:us-west-2:638386993804:targetgroup/14b0b7b5-30529-HTTP-87d6ed5/1cca8650182ba58f | Name: 14b0b7b5-30529-HTTP-87d6ed5.
[ALB-INGRESS] [kube-system/echoserver] [INFO]: Start Listener creation.
[ALB-INGRESS] [kube-system/echoserver] [INFO]: Completed Listener creation. ARN: arn:aws:elasticloadbalancing:us-west-2:638386993804:listener/app/14b0b7b5-kubesystem-echose-d1ad/8d78772a9d7a1a10/f75228bfccc385fb | Port: 80 | Proto: HTTP.
[ALB-INGRESS] [kube-system/echoserver] [INFO]: Start Rule creation.
[ALB-INGRESS] [kube-system/echoserver] [INFO]: Completed Rule creation. Rule Priority: "1" | Condition: [{    Field: "path-pattern",    Values: ["/"]  }]
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


