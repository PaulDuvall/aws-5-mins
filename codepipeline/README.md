**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS CodePipeline. 

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```
cd ~
sudo rm -rf ~/aws-encryption-workshop
git clone https://github.com/PaulDuvall/aws-encryption-workshop.git
cd aws-encryption-workshop/lesson6-detect
aws s3 mb s3://aws-5-mins-codepipeline-$(aws sts get-caller-identity --output text --query 'Account')
zip aws-5-mins-codepipeline.zip *.*
aws s3 sync ~/aws-encryption-workshop/lesson6-detect s3://aws-5-mins-codepipeline-$(aws sts get-caller-identity --output text --query 'Account')
```

1. Run this command to launch a CloudFormation stack that generates CodePipeline and related resources.  

```
aws cloudformation deploy \
--stack-name aws-5-mins-codepipeline \
--template-file ceoa-6-mcr-pipeline.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides EmailAddress=CHANGE-EMAIL-ADDRESS CodeCommitS3Bucket=aws-5-mins-codepipeline-$(aws sts get-caller-identity --output text --query 'Account') CodeCommitS3Key=aws-5-mins-codepipeline.zip \

--no-fail-on-empty-changeset \
--region us-east-2
```

* It takes about 4 minutes to launch the [CloudFormation stack](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks) and provision the CodePipeline resources.
* Go to the [CodePipeline Dashboard](https://us-east-2.console.aws.amazon.com/codepipeline/).


# Deployment Pipeline

# Pricing
TBD

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-codepipeline --region us-east-2
```

# Additional Resources
* [CodePipeline CloudFormation Stack](https://github.com/PaulDuvall/aws-encryption-workshop/tree/master/lesson6-detect)
