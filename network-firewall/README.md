**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS Network Firewall. With Network Firewall, you can deploy network security across your Amazon VPCs.

The demo is based on the [Automatically block suspicious traffic with AWS Network Firewall and Amazon GuardDuty](https://aws.amazon.com/blogs/security/automatically-block-suspicious-traffic-with-aws-network-firewall-and-amazon-guardduty/) blog post from AWS. The solution uses [Amazon GuardDuty](https://aws.amazon.com/guardduty/), [AWS Lambda](https://aws.amazon.com/lambda/), [AWS Security Hub](https://aws.amazon.com/security-hub/), [Amazon EventBridge](https://aws.amazon.com/eventbridge/), [AWS Step Functions](https://aws.amazon.com/step-functions/), and [Amazon VPC](https://aws.amazon.com/vpc/). It's launched via an [AWS CloudFormation](https://aws.amazon.com/cloudformation/) Stack. 

# CloudFormation Support
* [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html) - Define stateful, managed, network firewall and intrusion detection and prevention filtering for your VPCs in Amazon VPC.
* [AWS::NetworkFirewall::FirewallPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewallpolicy.html) - define the stateless and stateful network traffic filtering behavior for your [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).
* [AWS::NetworkFirewall::LoggingConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-loggingconfiguration.html) - define the destinations and logging options for an [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).
* [AWS::NetworkFirewall::RuleGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-rulegroup.html) - define a reusable collection of stateless or stateful network traffic filtering rules. You use rule groups in an [AWS::NetworkFirewall::FirewallPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewallpolicy.html) to specify the filtering behavior of an [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).

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
1. Check your email to find a message about traffic that was automatically blocked. 

# Pricing

## Network Firewall
* Network Firewall Endpoint	$0.395/hr.
* Network Firewall Traffic Processing $0.065/GB.
* Some NAT Gateway charges are waived when using AWS Network Firewall.

## GuardDuty
* AWS CloudTrail Management Event Analysis $4.00 per 1 million events per month.
* AWS CloudTrail S3 Data Event Analysis	$0.80 per 1 million events. Past 500 million events per month, this price reduces. 
* VPC Flow Log and DNS Log Analysis	$1.00 per GB. Past 500 GB per month, this price reduces.

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-networkfirewall-guardduty
```

# Additional Resources

* [Automatically block suspicious traffic with AWS Network Firewall and Amazon GuardDuty](https://aws.amazon.com/blogs/security/automatically-block-suspicious-traffic-with-aws-network-firewall-and-amazon-guardduty/)
* [Example code](https://github.com/aws-samples/aws-networkfirewall-guardduty)