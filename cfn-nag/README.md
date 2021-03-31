**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at TBD

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

TBD

```
sudo rm -rf ~/aws-5-mins-cfn-nag
mkdir ~/aws-5-mins-cfn-nag
aws s3 mb s3://aws-5-mins-cfn-nag-$(aws sts get-caller-identity --output text --query 'Account')
cd ~/aws-5-mins-cfn-nag

cd ~/aws-5-mins-cfn-nag
git clone https://github.com/PaulDuvall/aws-compliance-workshop.git
cd ~/aws-5-mins-cfn-nag/aws-compliance-workshop/lesson2-preventive
zip aws-5-mins-cfn-nag-examples.zip *.*
aws s3 sync ~/aws-5-mins-cfn-nag/aws-compliance-workshop/lesson2-preventive s3://aws-5-mins-cfn-nag-$(aws sts get-caller-identity --output text --query 'Account')

aws cloudformation deploy \
--stack-name ccoa-2-cfn-nag-pipeline \
--template-file ccoa-2-cfn-nag-pipeline.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides CodeCommitS3Bucket=aws-5-mins-cfn-nag-$(aws sts get-caller-identity --output text --query 'Account') CodeCommitS3Key=aws-5-mins-cfn-nag-examples.zip \
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