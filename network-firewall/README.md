**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS Network Firewall.

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```
sudo rm -rf ~/aws-networkfirewall-guardduty
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

1. Go to the [CloudFormation Console](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks). It'll take about three minutes for the stack to launch. 
1. In the **Outputs** tab for the CloudFormation stack, click on the link for the **GuardDutytoFirewallStateMachine** value.
1. Click on **Start execution**.
1. In the **Input** field, replace the contents with the contents from the AWS provided [test event JSON file](https://awsiammedia.s3.amazonaws.com/public/sample/606-Automatically-block-suspicious-traffic/securityhub-testevent.json).
1. Around line 55, find the **eventLastSeen** field and edit the timestamp to the current time in the UTC+0 time zone. For example: `2021-03-24T12:00:01.549Z`.

# Pricing

## Network Firewall
* TBD

## GuardDuty
* AWS CloudTrail Management Event Analysis $4.00 per 1 million events per month
* AWS CloudTrail S3 Data Event Analysis	$0.80 per 1 million events. Past 500 million events per month, this price reduces. 
* VPC Flow Log and DNS Log Analysis	$1.00 per GB. Past 500 GB per month, this price reduces.

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-networkfirewall-guardduty
```

# Additional Resources

* [Automatically block suspicious traffic with AWS Network Firewall and Amazon GuardDuty](https://aws.amazon.com/blogs/security/automatically-block-suspicious-traffic-with-aws-network-firewall-and-amazon-guardduty/)