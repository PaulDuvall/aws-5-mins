**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at TBD

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

TBD

```
sudo rm -rf ~/csoa-1
mkdir ~/csoa-1
aws s3 mb s3://csoa-1-$(aws sts get-caller-identity --output text --query 'Account')
cd ~/csoa-1

cd ~/csoa-1
git clone https://github.com/PaulDuvall/aws-compliance-workshop.git
cd ~/csoa-1/aws-compliance-workshop/lesson2-preventive
zip csoa-1-examples.zip *.*
aws s3 sync ~/csoa-1/aws-compliance-workshop/lesson2-preventive s3://csoa-1-$(aws sts get-caller-identity --output text --query 'Account')

aws cloudformation deploy \
--stack-name ccoa-2-cfn-nag-pipeline \
--template-file ccoa-2-cfn-nag-pipeline.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides EmailAddress=you@example.com CodeCommitS3Bucket=csoa-1-$(aws sts get-caller-identity --output text --query 'Account') CodeCommitS3Key=csoa-1-examples.zip \
--no-fail-on-empty-changeset \
--region us-east-1
```

# Deployment Pipeline

# Pricing
TBD

# Delete Resources

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `ccoa-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

aws s3api list-buckets --query 'Buckets[?starts_with(Name, `csoa-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME --region us-east-2
```

# Additional Resources