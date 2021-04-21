**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/). 


# CloudFormation Support


## Launch CloudFormation Stack
1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the commands below to launch the main CloudFormation Stack:

```
S3_BUCKET_NAME=aws-5-mins-secretsmanager-$(aws secretsmanager get-random-password --include-space --password-length 6 --no-exclude-numbers --exclude-uppercase --exclude-lowercase --exclude-punctuation --no-include-space --output text)
aws s3 mb s3://$S3_BUCKET_NAME
sudo rm -rf ~/aws-encryption-workshop
git clone https://github.com/PaulDuvall/aws-encryption-workshop.git
cp ~/aws-encryption-workshop/lesson3-develop/lambda-auto-rotate.zip ~/aws-encryption-workshop
cp ~/aws-encryption-workshop/lesson3-develop/lambda-auto-rotate.zip ~/aws-encryption-workshop
cd ~/aws-encryption-workshop/lesson3-develop

aws cloudformation deploy \
--stack-name aws-5-mins-secretsmanager \
--template-file ceoa-3-sm-vpc-nat-gateway.yml  \
--capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND \
--parameter-overrides S3BucketLambda=$S3_BUCKET_NAME \
S3KeyLambdaAutoRotate=lambda-auto-rotate.zip S3KeyPyMySQL=pymysql.zip \
--no-fail-on-empty-changeset \
--region us-east-2
```

TBD

* Go to the [AWS CloudFormation Console](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/) (search for the stacks beginning with `aws-5-mins-secretsmanager`). 
* Go to the [AWS Secrets Manager Console](https://us-east-2.console.aws.amazon.com/secretsmanager/home?region=us-east-2#!/listSecrets). 

# Pricing
For more information, see [AWS Secrets Manager Pricing](https://aws.amazon.com/secrets-manager/pricing/).

# Delete Resources

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `aws-5-mins-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force


aws cloudformation delete-stack --stack-name aws-5-mins-secretsmanager --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-secretsmanager --region us-east-2

```

# Additional Resources
