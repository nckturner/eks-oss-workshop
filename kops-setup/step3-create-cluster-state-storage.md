**a) Create s3 bucket to store cluster state**
```
aws s3api create-bucket \
    --bucket kops-state-store \
    --region us-east-1
```
**Note: s3 requires --create-bucket-configuration LocationConstraint=<region> for regions other than us-east-1**

**b) Version s3 bucket to revert or recover a previous state store**
```
aws s3api put-bucket-versioning --bucket kops-state-store  --versioning-configuration Status=Enabled
```
