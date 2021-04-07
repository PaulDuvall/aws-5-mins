**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at [AWS Config Rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_use-managed-rules.html) and remediations with [AWS Systems Manager Documents](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-ssm-docs.html).

AWS Config helps assess, audit, and evaluate the configurations of resources. With Config, you can see changes to resources and their relationships with other AWS resources. 

You can write Config Rules that compare current resource state to desired state. These rules can integrate with other services for alerting and remediation. 

You can create [Conformance Packs](https://docs.aws.amazon.com/config/latest/developerguide/conformance-packs.html) which couple rules with remediation across an AWS Organization.

Config helps with compliance auditing, security analysis, change management, and operational troubleshooting.

An AWS Systems Manager document (SSM document) defines the actions that Systems Manager performs on your managed instances. Systems Manager includes more than 100 pre-configured documents that you can use by specifying parameters at runtime.

# CloudFormation Support
* [AWS::Config::ConfigRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-config-configrule.html) - Specifies an AWS Config rule for evaluating whether your AWS resources comply with your desired configurations. 
* [AWS::Config::RemediationConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-config-remediationconfiguration.html) - Represents the details about the remediation configuration that includes the remediation action, parameters, and data to execute the action.
* [AWS::Config::ConformancePack](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-config-conformancepack.html) - A conformance pack is a collection of AWS Config rules and remediation actions that can be easily deployed in an account and a region.

# Example 1

## Launch CloudFormation Stack
1. Enable the AWS Config Recorder from the [AWS Config Console](https://us-east-2.console.aws.amazon.com/config/home?region=us-east-2#/dashboard).
1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run this command to get the latest code: 

```
sudo rm -rf ~/aws-5-mins
cd ~
git clone https://github.com/PaulDuvall/aws-5-mins.git
cd aws-5-mins/config
```

Then, run this command to launch a CloudFormation stack that generates the necessary IAM permissions for the Config Rules and remediations.

```
aws cloudformation deploy \
--stack-name aws-5-mins-s3-permissions \
--template-file s3-permissions.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-2
```

It takes about 1 minute to launch the [CloudFormation stack](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks) and provision the IAM permissions for this solution.

Next, run the command below to launch a CloudFormation stack that generates the Config Rules and remediation resources.

```
aws cloudformation deploy \
--stack-name aws-5-mins-s3-remediation \
--template-file s3-remediation.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-2
```

It takes about 1 minute to launch the [CloudFormation stack](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks) and provision the Config and related resources.

<!--1. Create a new S3 bucket by running this command: `aws s3 mb s3://aws-5-mins-config-$(aws sts get-caller-identity --output text --query 'Account') --region us-east-2`.-->
1. Wait about 15 minutes and then get the encryption for a specific S3 bucket by running this command: `aws s3api get-bucket-encryption --bucket s3serversideloggingbucket-$(aws sts get-caller-identity --output text --query 'Account') --region us-east-2`. You should received an error like this: **An error occurred (ServerSideEncryptionConfigurationNotFoundError) when calling the GetBucketEncryption operation: The server side encryption configuration was not found**.
1. Go back to the [AWS Config Dashboard](https://us-east-2.console.aws.amazon.com/config/home?region=us-east-2#/rules) to review the Config Rules.
1. Select **S3BucketServerSideEncryptionEnabled**. Click **Re-evaluate** from the **Actions** button. 
1. Wait about 10 minutes and go back to the [AWS Config Dashboard](https://us-east-2.console.aws.amazon.com/config/home?region=us-east-2#/rules).
1. Get bucket encryption again by running this command: `aws s3api get-bucket-encryption --bucket aws-5-mins-config-$(aws sts get-caller-identity --output text --query 'Account') --region us-east-2`. You should received no errors.


# Example 2 - Deplloyment Pipeline with EventBridge Rule, Config Rules, and Lambda Remediation

## Launch CloudFormation Stack
1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run this command to get the latest code: 

```
cd ~
aws configservice describe-configuration-recorders --query 'ConfigurationRecorders[?starts_with(name, `aws-5-mins-`) == `true`].[name]' --output text | xargs -I {} aws configservice delete-configuration-recorder --configuration-recorder-name {}
aws configservice describe-delivery-channels --query 'DeliveryChannels[?starts_with(name, `aws-5-mins-`) == `true`].[name]' --output text | xargs -I {} aws configservice delete-delivery-channel --delivery-channel-name {}
aws configservice describe-configuration-recorders --query 'ConfigurationRecorders[?starts_with(name, `default`) == `true`].[name]' --output text | xargs -I {} aws configservice delete-configuration-recorder --configuration-recorder-name {}
aws configservice describe-delivery-channels --query 'DeliveryChannels[?starts_with(name, `default`) == `true`].[name]' --output text | xargs -I {} aws configservice delete-delivery-channel --delivery-channel-name {}
sudo rm -rf ~/aws-encryption-workshop
aws s3 mb s3://aws-5-mins-eb-config-lambda-$(aws sts get-caller-identity --output text --query 'Account')
git clone https://github.com/PaulDuvall/aws-encryption-workshop.git
cd aws-encryption-workshop/lesson8-continuous
zip aws-5-mins-eb-config-lambda.zip *.*
aws s3 sync ~/aws-encryption-workshop/lesson8-continuous s3://aws-5-mins-eb-config-lambda-$(aws sts get-caller-identity --output text --query 'Account')
```

Next, run the command below to launch a CloudFormation stack that generates the Config Rules and remediation resources.

```
aws cloudformation deploy \
--stack-name aws-5-mins-eb-config-lambda \
--template-file ceoa-8-pipeline.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides S3ComplianceResourceId=aws-5-mins-encrypt-test-$(aws secretsmanager get-random-password --include-space --password-length 6 --no-exclude-numbers --exclude-uppercase --exclude-lowercase --exclude-punctuation --no-include-space --output text) CodeCommitS3Bucket=aws-5-mins-eb-config-lambda-$(aws sts get-caller-identity --output text --query 'Account') CodeCommitS3Key=aws-5-mins-eb-config-lambda.zip \
--no-fail-on-empty-changeset \
--region us-east-2
```

It takes about 4 minutes to launch the [CloudFormation stacks](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks) and provision the EventBridge, Config, Lambda, and related resources.

1. About 10 minutes **after** your CloudFormation stacks are **CREATE_COMPLETE**, run this command to create an unencrypted S3 bucket: 

```
aws s3 mb s3://$(aws cloudformation describe-stacks --stack-name aws-5-mins-eb-config-lambda \
--query "Stacks[0].Outputs[?OutputKey=='S3ComplianceResourceId'].OutputValue" \
--region us-east-2  --output text)
```

2. Get the encryption for a specific S3 bucket by running this command (You should received an error like this: **An error occurred (ServerSideEncryptionConfigurationNotFoundError) when calling the GetBucketEncryption operation: The server side encryption configuration was not found**): 

```
aws s3api get-bucket-encryption --bucket $(aws cloudformation describe-stacks --stack-name aws-5-mins-eb-config-lambda \
--query "Stacks[0].Outputs[?OutputKey=='S3ComplianceResourceId'].OutputValue" \
--region us-east-2  --output text) --region us-east-2
``` 

3. Go to the [Amazon EventBridge Console](https://us-east-2.console.aws.amazon.com/events/) and view the rule beginning with **aws-5-mins-eb-config-lambda**.
4. Go to the [AWS Lambda Functions Console](https://us-east-2.console.aws.amazon.com/lambda/home?region=us-east-2#/functions/) and view the function beginning with **aws-5-mins-eb-config-lambda-us-east-2-**.
5. Wait another 10 minutes and go back to the [AWS Config Dashboard](https://us-east-2.console.aws.amazon.com/config/home?region=us-east-2#/rules).
6. Get bucket encryption again by running this command (It should indicate that `SSEAlgorithm` is `AES256`. You should received no errors):

```
aws s3api get-bucket-encryption --bucket $(aws cloudformation describe-stacks --stack-name aws-5-mins-eb-config-lambda \
--query "Stacks[0].Outputs[?OutputKey=='S3ComplianceResourceId'].OutputValue" \
--region us-east-2  --output text) --region us-east-2
``` 

## View Code
* View [s3-remediation.yml](https://github.com/PaulDuvall/aws-5-mins/blob/main/config/s3-remediation.yml).
* View [s3-permissions.yml](https://github.com/PaulDuvall/aws-5-mins/blob/main/config/s3-permissions.yml).
* View [config-example.json](https://github.com/PaulDuvall/aws-5-mins/blob/main/config/config-example.json).
* View [event-pattern.json](https://github.com/PaulDuvall/aws-5-mins/blob/main/config/event-pattern.json).
```
aws events list-rules --name-prefix "aws-5-mins-eb-config-lambda" --query 'Rules[?starts_with(Name, `aws-5-mins-`) == `true`].[Name]' --output text | xargs -I {} aws events list-targets-by-rule --rule {}
```
* View [index.js](https://github.com/PaulDuvall/aws-encryption-workshop/blob/master/lesson8-continuous/index.js).


# Pricing
AWS Config charges $0.001 per rule evaluation per region for the first 100,000 rule evaluations. See [AWS Config Pricing](https://aws.amazon.com/config/pricing/) for more information. The rate goes down after the first 100,000 rule evaluations.

# Delete Resources

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `s3serversideloggingbucket-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `aws-5-mins-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

aws cloudformation delete-stack --stack-name aws-5-mins-s3-remediation --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-s3-remediation --region us-east-2

aws cloudformation delete-stack --stack-name aws-5-mins-s3-permissions --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-s3-permissions --region us-east-2

aws cloudformation delete-stack --stack-name aws-5-mins-eb-config-lambda-us-east-2 --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-eb-config-lambda-us-east-2 --region us-east-2

aws cloudformation delete-stack --stack-name aws-5-mins-eb-config-lambda --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-eb-config-lambda --region us-east-2

```

# Additional Resources
* [Deploy Conformance Packs across an Organization with Automatic Remediation](https://aws.amazon.com/blogs/mt/deploying-conformance-packs-across-an-organization-with-automatic-remediation/)
* [Operational-Best-Practices-for-Amazon-DynamoDB-with-Remediation.yaml](https://github.com/awslabs/aws-config-rules/blob/master/aws-config/Operational-Best-Practices-for-Amazon-DynamoDB-with-Remediation.yaml)
* ` aws secretsmanager get-random-password --include-space --password-length 6  --no-exclude-numbers --exclude-uppercase --exclude-lowercase --exclude-punctuation --no-include-space --output text`