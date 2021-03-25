**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS Network Firewall. With Network Firewall, you can apply firewall rules across multiple VPCs so that they you only need to define the rules in one place. As a fully managed service, it also scales with your network so you don't need to modify your infrastructure as your needs grow.  

You can integrate AWS Network Firewall with AWS Firewall Manager so that it can be used with AWS Organizations and apply rules across multiple AWS accounts.

Can run stateless and stateful rules engines that inspects network traffic. For example, with stateless rules, you can filter traffic based on source IPs,  domains, or pattern matching and then pass, drop, or forward traffic to stateful rules. 

# CloudFormation Support
* [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html) - Define stateful, managed, network firewall and intrusion detection and prevention filtering for your VPCs in Amazon VPC.
* [AWS::NetworkFirewall::FirewallPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewallpolicy.html) - define the stateless and stateful network traffic filtering behavior for your [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).
* [AWS::NetworkFirewall::LoggingConfiguration](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-loggingconfiguration.html) - define the destinations and logging options for an [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).
* [AWS::NetworkFirewall::RuleGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-rulegroup.html) - define a reusable collection of stateless or stateful network traffic filtering rules. You use rule groups in an [AWS::NetworkFirewall::FirewallPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewallpolicy.html) to specify the filtering behavior of an [AWS::NetworkFirewall::Firewall](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-networkfirewall-firewall.html).


## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-1.console.aws.amazon.com/cloudshell/home?region=us-east-1#) in the **us-east-1** region, run the following commands: 

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
--region us-east-1
```

1. Go to the [CloudFormation Console](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks). It'll take about 7 minutes for the stack to launch.

# Pricing
* Network Firewall Endpoint $0.395/hr.
* Network Firewall Traffic Processing $0.065/GB.
* Some NAT Gateway charges are waived when using AWS Network Firewall.
* For more information, see [AWS Network Firewall Pricing](https://aws.amazon.com/network-firewall/pricing/).

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-networkfirewall --region us-east-1
```

It'll take about 5 minutes to delete all the resources in the stack.

# Additional Resources
* [AWS Network Firewall – New Managed Firewall Service in VPC](https://aws.amazon.com/blogs/aws/aws-network-firewall-new-managed-firewall-service-in-vpc/)
* [Enforce your AWS Network Firewall protections at scale with AWS Firewall Manager](https://aws.amazon.com/blogs/security/enforce-your-aws-network-firewall-protections-at-scale-with-aws-firewall-manager/)