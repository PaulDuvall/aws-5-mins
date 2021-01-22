# Launch CloudFormation Stack

```
aws cloudformation create-stack --stack-name devops-guru \
   --template-body file://devops-guru.yml \
   --capabilities CAPABILITY_IAM
```