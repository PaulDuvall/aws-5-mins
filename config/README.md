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
1. Wait about 15 minutes and then get the encryption for a specific S3 bucket by running this command: `aws s3api get-bucket-encryption --bucket s3serversideloggingbucket-$(aws sts get-caller-identity --output text --query 'Account') --region us-east-2`. You should received an error like this: `An error occurred (ServerSideEncryptionConfigurationNotFoundError) when calling the GetBucketEncryption operation: The server side encryption configuration was not found`.
1. Go back to the [AWS Config Dashboard](https://us-east-2.console.aws.amazon.com/config/home?region=us-east-2#/rules) to review the Config Rules.
1. Select **S3BucketServerSideEncryptionEnabled**. Click **Re-evaluate** from the **Actions** button. 
1. Wait about 10 minutes and go back to the [AWS Config Dashboard](https://us-east-2.console.aws.amazon.com/config/home?region=us-east-2#/rules).
1. Get bucket encryption again by running this command: `aws s3api get-bucket-encryption --bucket aws-5-mins-config-$(aws sts get-caller-identity --output text --query 'Account') --region us-east-2`. You should received no errors.


# Example 2

## Launch CloudFormation Stack
1. Enable the AWS Config Recorder from the [AWS Config Console](https://us-east-2.console.aws.amazon.com/config/home?region=us-east-2#/dashboard).
1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run this command to get the latest code: 

```
sudo rm -rf ~/aws-encryption-workshop
cd ~
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
--parameter-overrides S3ComplianceResourceId=aws-5-mins-unencrypted-$(aws sts get-caller-identity --output text --query 'Account') CodeCommitS3Bucket=aws-5-mins-eb-config-lambda-$(aws sts get-caller-identity --output text --query 'Account') CodeCommitS3Key=aws-5-mins-eb-config-lambda.zip \
--no-fail-on-empty-changeset \
--region us-east-2
```

It takes about 1 minute to launch the [CloudFormation stack](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks) and provision the Config and related resources.

1. Wait about 15 minutes and then get the encryption for a specific S3 bucket by running this command: `aws s3api get-bucket-encryption --bucket s3serversideloggingbucket-$(aws sts get-caller-identity --output text --query 'Account') --region us-east-2`. You should received an error like this: `An error occurred (ServerSideEncryptionConfigurationNotFoundError) when calling the GetBucketEncryption operation: The server side encryption configuration was not found`.
1. Go back to the [AWS Config Dashboard](https://us-east-2.console.aws.amazon.com/config/home?region=us-east-2#/rules) to review the Config Rules.
1. Select **S3BucketServerSideEncryptionEnabled**. Click **Re-evaluate** from the **Actions** button. 
1. Wait about 10 minutes and go back to the [AWS Config Dashboard](https://us-east-2.console.aws.amazon.com/config/home?region=us-east-2#/rules).
1. Get bucket encryption again by running this command: `aws s3api get-bucket-encryption --bucket aws-5-mins-eb-config-lambda-$(aws sts get-caller-identity --output text --query 'Account') --region us-east-2`. You should received no errors.

## View Code
1. View [s3-remediation.yml](https://github.com/PaulDuvall/aws-5-mins/blob/main/config/s3-remediation.yml).
1. View [s3-permissions.yml](https://github.com/PaulDuvall/aws-5-mins/blob/main/config/s3-permissions.yml).

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

aws cloudformation delete-stack --stack-name aws-5-mins-eb-config-lambda --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-eb-config-lambda --region us-east-2

```

# Additional Resources
* [Deploy Conformance Packs across an Organization with Automatic Remediation](https://aws.amazon.com/blogs/mt/deploying-conformance-packs-across-an-organization-with-automatic-remediation/)
* [Operational-Best-Practices-for-Amazon-DynamoDB-with-Remediation.yaml](https://github.com/awslabs/aws-config-rules/blob/master/aws-config/Operational-Best-Practices-for-Amazon-DynamoDB-with-Remediation.yaml)