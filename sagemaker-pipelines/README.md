**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at Amazon SageMaker Pipelines. 

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

Run the following steps to launch resources that run a canary test with Synthetics.

1. From your [AWS CloudShell Environment](https://us-east-1.console.aws.amazon.com/cloudshell/home?region=us-east-1#) in the **us-east-1** region, run the following commands: 
```
sudo rm -rf ~/aws-5-mins
cd ~/
git clone https://github.com/PaulDuvall/aws-5-mins.git
cd aws-5-mins/sagemaker-pipelines
```

1. Run this command to launch a CloudFormation stack.  

```
aws cloudformation deploy \
--stack-name aws-5-mins-sagemaker-pipeline \
--template-file sagemaker-pipeline.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-1
```

# Pricing
TBD

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-sagemaker-pipeline
```