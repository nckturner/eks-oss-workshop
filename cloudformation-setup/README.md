# Setting up your EKS Cluster

This tutorial will take you through a fairly opinionated way to set up an EKS cluster--certainly not what you would want to do in a production setup, but enough to get a cluster up and running.  We will be using cloudformation to create all of our AWS resources, including the cluster itself.

## 1. Create an IAM user

The first thing to do, to make this experience consistent, is to create a user that will be your kubernetes cluster administrator.  This can be done through the console or the CLI.  [Follow instructions here](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html).  Things to do:

1. Name your user KubernetesAdmin (or something similar).
1. Give your user the policy `arn:aws:iam::aws:policy/AdministratorAccess` because this isn't a demo about security.
1. Give your user console access.
1. Set a password for your user.
1. Create credentials for your user through the console.
1. Verify that you are currently acting as your user, e.g.:

```
aws sts get-caller-identity
```

Response:
```
{
    "UserId": "AIDAXXXXXXXXXXXXXXXXX",
    "Account": "358888888888",
    "Arn": "arn:aws:iam::358888888888:user/Nick"
}
```

## 2. Create the Cloudformation Stack

Replace `<YOUR EC2 KEY HERE>` with the name of a key, which you can create from the EC2 console.

```
export NAME=MyEksCluster
export KEY_NAME=<YOUR EC2 KEY HERE>
aws cloudformation create-stack \
    --stack-name $NAME \
    --template-body file://eks-cluster.yaml \
    --parameters \
        ParameterKey=ClusterName,ParameterValue=$NAME \
        ParameterKey=KeyName,ParameterValue=$KEY_NAME \
    --capabilities CAPABILITY_IAM
```
## 3. Create your kubeconfig

Copy the cloudformation outputs into your kubeconfig file (replace the cooresponding values).

1. `EKSClusterCA`
1. `EKSClusterEndpoint`
1. `EKSClusterName`

Copy the kubeconfig into the correct location:

```
mkdir ~/.kube
cp kubeconfig ~/.kube/config
```

## 3. Create Auth Mapping ConfigMap

Copy `NodeInstanceRoleArn` into the aws-auth-cm.yaml file.

Then, apply it to the cluster by running:

```
kubectl apply -f aws-auth-cm.yaml
```

You should see nodes joining now if everything went well.

```
kubectl get nodes
```

## 4. Do Something Cool (profit?)
```
kubectl run -i --tty busybox --image=busybox --restart=Never
```

## 5. Also, check out eksctl
```
git clone git@github.com:weaveworks/eksctl.git
```
