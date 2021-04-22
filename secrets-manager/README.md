**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/). It secures, stores, and tightly controls access to tokens, passwords, certificates, API keys, and other secrets while performing automatic secrets rotation, generating random secrets, and cross-account access.

While most of us know not to store secret data in plain text files or environment variables, it's not always obvious on which tools to use and how to use them to encrypt these secrets. In adhering to the principle of least privilege, you also want to limit those who have access to ever see the values of these secrets.

With Secrets Manager you can safely store these secrets and automatically generate and rotate secrets while providing fine-grained policies to prevent access.

In the demo, I'll launch a deployment pipeline using AWS CodePipeline that creates an RDS database, generates a random secret in Secrets Manager, and attaches the secret to the RDS database. Finally, it provisions a Lambda function that performs automatic rotation of the secret.

# CloudFormation Support
* [AWS::SecretsManager::ResourcePolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-secretsmanager-resourcepolicy.html) - Resource-based permission policy to a secret to limit access to only those that need it.
* [AWS::SecretsManager::RotationSchedule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-secretsmanager-rotationschedule.html) - Configures the secrets rotation including how often the secret gets rotated. 
* [AWS::SecretsManager::Secret](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-secretsmanager-secret.html) - Creates a secret and stores it in Secrets Manager.
* [AWS::SecretsManager::SecretTargetAttachment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-secretsmanager-secrettargetattachment.html) - Attach a secret to a database.

## Launch CloudFormation Stack
1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the commands below to launch the main CloudFormation Stack:

```
cd ~
RANDOM_ID=$(aws secretsmanager get-random-password --include-space --password-length 6 --no-exclude-numbers --exclude-uppercase --exclude-lowercase --exclude-punctuation --no-include-space --output text)
S3_BUCKET_NAME=aws-5-mins-secretsmanager-$RANDOM_ID
aws s3 mb s3://$S3_BUCKET_NAME
sudo rm -rf ~/aws-encryption-workshop
git clone https://github.com/PaulDuvall/aws-encryption-workshop.git
cp ~/aws-encryption-workshop/lesson3-develop/lambda-auto-rotate.zip ~/aws-encryption-workshop
cp ~/aws-encryption-workshop/lesson3-develop/lambda-auto-rotate.zip ~/aws-encryption-workshop
cd ~/aws-encryption-workshop/lesson3-develop
zip aws-5-mins-secretsmanager.zip *.*
aws s3 sync ~/aws-encryption-workshop/lesson3-develop s3://$S3_BUCKET_NAME

aws cloudformation deploy \
--stack-name aws-5-mins-secretsmanager \
--template-file ceoa-3-rotation-1-pipeline.yml  \
--capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND CAPABILITY_NAMED_IAM \
--parameter-overrides EmailAddress=fake-email@fake-fake-fake-email.com \
CodeCommitS3Bucket=$S3_BUCKET_NAME  CodeCommitS3Key=aws-5-mins-secretsmanager.zip \
--no-fail-on-empty-changeset \
--region us-east-2
```

It will take about one minute to launch the CloudFormation stack. Once the stack is **CREATE_COMPLETE**, click on the [stack](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/) (starting with `aws-5-mins-secretsmanager`). Then, go to the **Outputs** pane and click on the Value for the *PipelineUrl* Key. This launches a CodePipeline pipeline. It will take another **15 minutes** for the pipeline to provision a VPC, create and populate a CodeCommit repository, build and deploy a Lambda function that rotates the MySQL admin password, create a MySQL Database in Amazon RDS, create a Secret and Rotation Schedule in AWS Secrets Manager, and link all the relevant services.

1. Go to the [AWS Secrets Manager Console](https://us-east-2.console.aws.amazon.com/secretsmanager/home?region=us-east-2#!/listSecrets). 
1. Choose the generated Secret that begins with `MyRDSInstanceRotationSecret`.
1. Click on **Retrieve secret value** and view the password. Click **Close**.
1. Click on **Retrieve secret immediately** and click **Rotate**.
1. Click on **Retrieve secret value** again and view the password. Click **Close**. Note the new password. 

# Pricing
For more information, see [AWS Secrets Manager Pricing](https://aws.amazon.com/secrets-manager/pricing/).

# Delete Resources

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `aws-5-mins-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

aws cloudformation delete-stack --stack-name aws-5-mins-secretsmanager-us-east-2-rds --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-secretsmanager-us-east-2-rds --region us-east-2

aws cloudformation delete-stack --stack-name aws-5-mins-secretsmanager-us-east-2-lambda --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-secretsmanager-us-east-2-lambda --region us-east-2

aws cloudformation delete-stack --stack-name aws-5-mins-secretsmanager-us-east-2-vpc --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-secretsmanager-us-east-2-vpc --region us-east-2

aws cloudformation delete-stack --stack-name aws-5-mins-secretsmanager --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-secretsmanager --region us-east-2

```