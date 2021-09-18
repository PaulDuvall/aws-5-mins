## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```
cd ~
aws configservice describe-configuration-recorders --query 'ConfigurationRecorders[?starts_with(name, `aws-5-mins-`) == `true`].[name]' --output text | xargs -I {} aws configservice delete-configuration-recorder --configuration-recorder-name {}
aws configservice describe-delivery-channels --query 'DeliveryChannels[?starts_with(name, `aws-5-mins-`) == `true`].[name]' --output text | xargs -I {} aws configservice delete-delivery-channel --delivery-channel-name {}
aws configservice describe-configuration-recorders --query 'ConfigurationRecorders[?starts_with(name, `default`) == `true`].[name]' --output text | xargs -I {} aws configservice delete-configuration-recorder --configuration-recorder-name {}
aws configservice describe-delivery-channels --query 'DeliveryChannels[?starts_with(name, `default`) == `true`].[name]' --output text | xargs -I {} aws configservice delete-delivery-channel --delivery-channel-name {}
sudo rm -rf ~/aws-5-mins-ce
mkdir ~/aws-5-mins-ce
aws s3 mb s3://aws-5-mins-ce-$(aws sts get-caller-identity --output text --query 'Account')
cd ~/aws-5-mins-ce

cd ~/aws-5-mins-ce
git clone https://github.com/PaulDuvall/aws-5-mins.git --branch main  
cd ~/aws-5-mins-ce/aws-5-mins/ce
zip aws-5-mins-ce-examples.zip *.*
aws s3 sync ~/aws-5-mins-ce/aws-5-mins/ce s3://aws-5-mins-ce-$(aws sts get-caller-identity --output text --query 'Account')

aws cloudformation deploy \
--stack-name aws-5-mins-ce-pipeline \
--template-file ce-pipeline.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides CodeCommitS3Bucket=aws-5-mins-ce-$(aws sts get-caller-identity --output text --query 'Account') CodeCommitS3Key=aws-5-mins-ce-examples.zip \
S3ComplianceResourceId=ce-s3-unencrypted-$(aws sts get-caller-identity --output text --query 'Account') \
--no-fail-on-empty-changeset \
--region us-east-2
```

* It takes about 1 minute to launch the [CloudFormation stack](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks) and provision the CodePipeline resources.

# Delete Resources

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `aws-5-mins-ce-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

aws cloudformation delete-stack --stack-name aws-5-mins-ce-pipeline-volume-us-east-2 --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-ce-pipeline-volume-us-east-2 --region us-east-2

aws cloudformation delete-stack --stack-name aws-5-mins-ce-pipeline --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-ce-pipeline --region us-east-2


```