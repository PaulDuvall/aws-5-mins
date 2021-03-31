**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS CodePipeline. 

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```
git clone https://github.com/aws-samples/amazon-macie-demo-with-sample-data.git
cd amazon-macie-demo-with-sample-data
```

1. Run this command to launch a CloudFormation stack that generates CodePipeline and related resources.  

```
aws cloudformation deploy \
--stack-name aws-5-mins-macie \
--template-file macie.yaml \
--capabilities CAPABILITY_NAMED_IAM \
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
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME --region us-east-2
```

# Additional Resources
* [CodePipeline CloudFormation Stack](https://github.com/PaulDuvall/aws-encryption-workshop/tree/master/lesson6-detect)
