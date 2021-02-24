**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at Amazon CloudWatch Synthetics.

Amazon has been using automated synthetic testing for many years. The purpose of this approach is to run tests and analysis against production systems to learn of potential problems before end users do.

For example, you can run these automated tests to ensure a key part of your system (e.g. ordering) continues to work. If there are any errors or degradation, you learn of it as soon as possible and, in many cases, even before your end users.

Amazon CloudWatch Synthetics makes it possible to run these tests and monitor them through the CloudWatch console. What's more, you can integrate Synthetics with [AWS X-Ray](https://aws.amazon.com/xray/) to accelerate your debugging process.

CloudWatch Synthetics makes it easy to:

* Run web tests
* Monitor APIs
* Get screenshots of behavior
* Get alerted through Alarms

# CloudFormation Support

AWS CloudFormation provides native support for Synthetics with the [AWS::Synthetics::Canary](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-synthetics-canary.html) resource. With this, you can creates or update a canary test. Canaries are scripts that monitor your endpoints and APIs from the outside-in. 

## Launch CloudFormation Stack

Run the following steps to launch resources that run a canary test with Synthetics.

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 
```
sudo rm -rf ~/aws-5-mins
cd ~/
git clone https://github.com/PaulDuvall/aws-5-mins.git
cd aws-5-mins/synthetics
```

1. Run this command to launch a CloudFormation stack that generates a Canary test. In the example, the default parameter value uses Amazon.com but you can change it to a website you own to tweak the behavior.  

```
aws cloudformation deploy \
--stack-name aws-5-mins-synthetics \
--template-file synthetics.yml \
--parameter-overrides TestUrl=https://www.amazon.com/broken \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-2
```

View the status by going to the [AWS CloudFormation](https://console.aws.amazon.com/cloudformation/home?region=us-east-2#) console. Once the status is **CREATE_COMPLETE**, view the [Synthetics Canary Test](https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#synthetics:canary/detail/aws-5-mins-canary).

# Pricing
When running Amazon CloudWatch Synthetics, you are charged $0.0012 per canary run. For example, by running 10,000 canary runs in a given month (or around one every 5 minutes), you will pay $12.

# Delete Resources

Run the commands below to delete all the resources associated with this solution. 

```
aws cloudformation delete-stack --stack-name aws-5-mins-synthetics
```

# Additional Resources

* [AWS::Synthetics::Canary](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-synthetics-canary.html)
* [Using synthetic monitoring](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries.html)
* [Amazon CloudWatch Synthetics Demo](https://www.youtube.com/watch?v=hF3NM9j-u7I)
* [AWS re:Invent 2019 DevOps and Security re:Cap](https://stelligent.com/2019/12/17/aws-reinvent-2019-devops-and-security-recap/)
* [Sample code for canary scripts](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_Samples.html)