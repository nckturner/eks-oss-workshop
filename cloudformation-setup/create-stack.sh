#!/bin/bash

export NAME=MyEksCluster
export KEY_NAME=<YOUR EC2 INSTANCE KEY HERE>

aws cloudformation create-stack \
    --stack-name $NAME \
    --template-body file://eks-cluster.yaml \
    --parameters \
        ParameterKey=ClusterName,ParameterValue=$NAME \
        ParameterKey=KeyName,ParameterValue=$KEY_NAME \
    --capabilities CAPABILITY_IAM
