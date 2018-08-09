## Fetch some cluster information

```
$ eksctl get clusters
2018-07-16T13:26:08-07:00 [ℹ]  cluster = {
  Arn: "arn:aws:eks:us-west-2:638386993804:cluster/scrumptious-unicorn-1531766433",
  CertificateAuthority: {
    Data: "XXX"
  },
  CreatedAt: 2018-07-16 18:41:36 +0000 UTC,
  Endpoint: "https://9889487843E33EC043CDB784E93DD778.sk1.us-west-2.eks.amazonaws.com",
  Name: "scrumptious-unicorn-1531766433",
  ResourcesVpcConfig: {
    SecurityGroupIds: ["sg-7766f307"],
    SubnetIds: ["subnet-a12f4cea","subnet-e37e389a","subnet-a7396afd"],
    VpcId: "vpc-41c72f39"
  },
  RoleArn: "arn:aws:iam::638386993804:role/EKS-scrumptious-unicorn-1-AWSServiceRoleForAmazonE-16E7SIYUKWVBF",
  Status: "ACTIVE",
  Version: "1.10"
}
```

Set some environment variables we will use later.

```
export REGION=us-west-2
export CLUSTER_NAME=scrumptious-unicorn-1531766433
export VPCID=vpc-41c72f39
```

## Tag the subnets

There are some standard tags that are used by Kubernetes to detect which subnets should be used for different types of resources. Eksctl doesn’t add these tags yet so we need to do that manually.

```
$ for subnetId in `aws ec2 describe-subnets --region $REGION --filter Name="tag:eksctl.cluster.k8s.io/v1alpha1/cluster-name",Values="$CLUSTER_NAME" --query 'Subnets[*].SubnetId' --output text`
	do aws ec2 create-tags --region $REGION --tags Key="kubernetes.io/role/elb",Value="" --resources $subnetId
done
```

## Create IAM user for controller

```
$ aws iam create-group --group-name $CLUSTER_NAME-ingress
$ aws iam create-policy --policy-name $CLUSTER_NAME-ingress --policy-document file://iam-policy.json
$ aws iam attach-group-policy --group-name $CLUSTER_NAME-ingress --policy-arn <ARN FROM OUTPUT>
$ aws iam create-user --user-name $CLUSTER_NAME-ingress
$ aws iam add-user-to-group --user-name $CLUSTER_NAME-ingress --group-name $CLUSTER_NAME-ingress
$ aws iam create-access-key --user-name $CLUSTER_NAME-ingress
```
