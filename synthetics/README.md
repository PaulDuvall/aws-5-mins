**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at Amazon CloudWatch Synthetics.

TBD


# CloudFormation Support
* [AWS::Synthetics::Canary](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-synthetics-canary.html)

## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-1.console.aws.amazon.com/cloudshell/home?region=us-east-1#) in the **us-east-1** region, run the following commands: 

```
sudo rm -rf ~/aws-5-mins
cd ~/
git clone https://github.com/PaulDuvall/aws-5-mins.git
cd aws-5-mins/synthetics
```

1. Run this command to launch a CloudFormation stack that generates an SQS resource.  

```
aws cloudformation deploy \
--stack-name aws-5-mins-synthetics \
--template-file synthetics.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-1
```

# Deployment Pipeline

# Pricing
When running Amazon CloudWatch Synthetics, you are charged $0.0012 per canary run. For example, by running 10,000 canary runs in a given month (or around one every 5 minutes), you will pay $12.

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME
```

# Additional Resources

* [AWS::Synthetics::Canary](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-synthetics-canary.html)
* [Using synthetic monitoring](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries.html)
* [Amazon CloudWatch Synthetics Demo](https://www.youtube.com/watch?v=hF3NM9j-u7I)
* [AWS re:Invent 2019 DevOps and Security re:Cap](https://stelligent.com/2019/12/17/aws-reinvent-2019-devops-and-security-recap/)