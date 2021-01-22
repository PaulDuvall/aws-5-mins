# Launch CloudFormation Stack

```
aws cloudformation create-stack --stack-name audit-manager \
   --template-body file://audit-manager.yml \
   --capabilities CAPABILITY_IAM
```