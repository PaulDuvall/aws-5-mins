**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at TBD

TBD


# CloudFormation Support
* [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html) - Define stateful, managed, network firewall and intrusion detection and prevention filtering for your VPCs in Amazon VPC.
* [AWS::NetworkFirewall::FirewallPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewallpolicy.html) - define the stateless and stateful network traffic filtering behavior for your [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).
* [AWS::NetworkFirewall::LoggingConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-loggingconfiguration.html) - define the destinations and logging options for an [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).
* [AWS::NetworkFirewall::RuleGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-rulegroup.html) - define a reusable collection of stateless or stateful network traffic filtering rules. You use rule groups in an [AWS::NetworkFirewall::FirewallPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewallpolicy.html) to specify the filtering behavior of an [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).



## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```
cd ~
sudo rm -rf ~/aws-5-mins
git clone https://github.com/PaulDuvall/aws-5-mins.git
cd aws-5-mins/network-firewall


aws cloudformation deploy \
--stack-name aws-5-mins-networkfirewall \
--template-file network-firewall.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-2
```

1. Go to the [CloudFormation Console](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks). It'll take about three minutes for the stack to launch.

# Pricing
TBD

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME --region us-east-2
```

# Additional Resources