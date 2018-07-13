**For a gossip-based cluster, make sure the name ends with k8s.local**

export NAME=myfirstcluster.k8s.local
export KOPS_STATE_STORE=s3://example-com-state-store

**Note which availability zones are available to you**

aws ec2 describe-availability-zones --region us-west-2

**Create kops based k8s cluster**

kops create cluster \
    --zones us-west-2a \
    ${NAME}

**Build k8s cluster**

kops update cluster ${NAME} --yes

**Check if the k8s API is online and listening**

kubectl get nodes

**Validate the cluster**

kops validate cluster

**Look at all the system components**

kubectl -n kube-system get po
