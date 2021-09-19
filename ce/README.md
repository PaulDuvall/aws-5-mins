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

## Test the Deployment

First, verify that the [CloudFormation](https://console.aws.amazon.com/cloudformation/) stack you just launched (called **ce-ar**) was successfully created. Click on the **PipelineUrl** Output to launch deployment pipeline in CodePipeline to see it running. Verify that the pipeline successfully went through all stages (as shown below).

Next, you will create an unencrypted S3 bucket that allows people to store files to the bucket. Here are the steps:

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands:
```aws s3 mb s3://aws-5-mins-ce-s3-unencrypted-$(aws sts get-caller-identity --output text --query 'Account')```
1. Go to the [S3](https://console.aws.amazon.com/s3/) console and select the `aws-5-mins-ce-s3-unencrypted-ACCOUNTID` bucket and choose the *Properties* pane.
1. Verify that the **Default encryption** is *Disabled*.

### Verify Compliance
In this section, you will verify that the Config Rule has been triggered and that the S3 bucket resource has been automatically remediated.
1. Go to the [Config](https://console.aws.amazon.com/config/) console.
2. Click on **Rules**.
3. Select the **s3-bucket-server-side-encryption-enabled** rule.
4. Click the **Re-evaluate** button.
5. Go back to **Rules** in the [Config](https://console.aws.amazon.com/config/) console.
6. Go to the [S3](https://console.aws.amazon.com/s3/) console and choose the `aws-5-mins-ce-s3-unencrypted-ACCOUNTID` bucket
7. Verify that the **Default encryption** is *Enabled*.
8. Go back to **Rules** in the [Config](https://console.aws.amazon.com/config/) console and confirm that the **s3-bucket-server-side-encryption-enabled** rule is **Compliant**. 

# Delete Resources

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `aws-5-mins-ce-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

aws cloudformation delete-stack --stack-name aws-5-mins-ce-pipeline-us-east-2 --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-ce-pipeline-us-east-2 --region us-east-2

aws cloudformation delete-stack --stack-name aws-5-mins-ce-pipeline --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-ce-pipeline --region us-east-2


```