**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS CodePipeline. CodePipeline is a fully-managed Continuous Delivery service which provides an automated workflow for releasing software to end users. It integrates many AWS services and 3rd-party tools and you can create your own custom integrations as well. Every time there's a code change, it gets the latest code from source control, builds it, tests it, deploys, and releases it to end users. At any point, you can see a visualized workflow of the state of a release for any revision.

CodePipeline is composed of a series of stages. Stages are composed of a collection of actions. Actions perform the work in a pipeline. Within actions, you will see integrations with other tools, running commands to build, test, deploy, and release your service.

Currently, there are six action types. They are: Source, Build, Test, Deploy, Invoke, and Approval. You can run actions in parallel. A stage is not complete until all actions are successful.

# CloudFormation Support
* [AWS::CodePipeline::CustomActionType](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-codepipeline-customactiontype.html) - Creates a custom action within a pipeline for a non-supported resource.
* [AWS::CodePipeline::Pipeline](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-codepipeline-pipeline.html) - Provisions the pipeline workflow itself that defines the series of stages and actions that makeup the pipeline.
* [AWS::CodePipeline::Webhook](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-codepipeline-webhook.html) - Provisons the webhook that triggers your pipeline to start every time an external event occurs.

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
--parameter-overrides RepositoryBranch=main CodeCommitS3Bucket=aws-5-mins-codepipeline-$(aws sts get-caller-identity --output text --query 'Account') CodeCommitS3Key=aws-5-mins-codepipeline.zip \
--no-fail-on-empty-changeset \
--region us-east-2
```

* It takes about 1 minute to launch the [CloudFormation stack](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks) and provision the CodePipeline resources.
* Go to the [CodePipeline Dashboard](https://us-east-2.console.aws.amazon.com/codepipeline/).

# Pricing
You a charged $1.00 per active pipeline per month. An active pipeline is one that has been running for at least 30 days. For more information, see [CodePipeline Pricing](https://aws.amazon.com/codepipeline/pricing/).

# Delete Resources

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `aws-5-mins-codepipeline`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force
aws cloudformation delete-stack --stack-name aws-5-mins-codepipeline-us-east-2 --region us-east-2
aws cloudformation delete-stack --stack-name aws-5-mins-codepipeline --region us-east-2
```

# Additional Resources
* [CodePipeline CloudFormation Stack](https://github.com/PaulDuvall/aws-encryption-workshop/tree/master/lesson6-detect)
