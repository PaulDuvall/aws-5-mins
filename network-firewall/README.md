**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS Network Firewall.

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```
git clone https://github.com/aws-samples/aws-networkfirewall-guardduty.git
cd aws-networkfirewall-guardduty/templates


aws cloudformation deploy \
--stack-name aws-5-mins-networkfirewall-guardduty \
--template-file aws-networkfirewall-guardduty.template \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides AdminEmail=CHANGE-EMAIL-ADDRESS \
--no-fail-on-empty-changeset \
--region us-east-2
```

Go to the [CloudFormation Console](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks).


# Pricing
* AWS CloudTrail Management Event Analysis $4.00 per 1 million events per month
* AWS CloudTrail S3 Data Event Analysis	$0.80 per 1 million events. Past 500 million events per month, this price reduces. 
* VPC Flow Log and DNS Log Analysis	$1.00 per GB. Past 500 GB per month, this price reduces.

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME
```

# Additional Resources

* [Automatically block suspicious traffic with AWS Network Firewall and Amazon GuardDuty](https://aws.amazon.com/blogs/security/automatically-block-suspicious-traffic-with-aws-network-firewall-and-amazon-guardduty/)