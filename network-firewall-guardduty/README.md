**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS Network Firewall. With Network Firewall, you can deploy network security across your Amazon VPCs.

The demo is based on the [Automatically block suspicious traffic with AWS Network Firewall and Amazon GuardDuty](https://aws.amazon.com/blogs/security/automatically-block-suspicious-traffic-with-aws-network-firewall-and-amazon-guardduty/) blog post from AWS. The solution uses [Amazon GuardDuty](https://aws.amazon.com/guardduty/), [AWS Lambda](https://aws.amazon.com/lambda/), [AWS Security Hub](https://aws.amazon.com/security-hub/), [Amazon EventBridge](https://aws.amazon.com/eventbridge/), [AWS Step Functions](https://aws.amazon.com/step-functions/), and [Amazon VPC](https://aws.amazon.com/vpc/). It's launched via an [AWS CloudFormation](https://aws.amazon.com/cloudformation/) Stack. 


## Launch CloudFormation Stack

1. Launch a Cloud9 Environment in **us-east-2** using these [instructions](https://github.com/PaulDuvall/aws-5-mins/tree/main/cloud9). Be sure to change the `CHANGE-EMAIL-ADDRESS` token to your email address.

```
sudo rm -rf ~/environment/aws-networkfirewall-guardduty
git clone https://github.com/aws-samples/aws-networkfirewall-guardduty.git
cd aws-networkfirewall-guardduty/templates


aws cloudformation deploy \
--stack-name aws-5-mins-networkfirewall-guardduty \
--template-file aws-networkfirewall-guardduty.template \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides AdminEmail=CHANGE-EMAIL-ADDRESS Retention=5 \
--no-fail-on-empty-changeset \
--region us-east-2
```

1. Go to the [CloudFormation Console](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks). It'll take about three minutes for the stack to launch.
1. While the stack is being created, be sure to confirm the email that's been sent to you from Amazon SNS. 
1. From your Cloud9 environment, open the file located at **aws-networkfirewall-guardduty/tests/securityhub-testevent.json**.
1. Around line 55, find the **eventLastSeen** field and edit the timestamp to the current time in the UTC+0 time zone. For example: `2021-03-24T12:00:01.549Z`.
1. Once the stack is **CREATE_COMPLETE**, go to the **Outputs** tab for the CloudFormation stack and click on the link for the **GuardDutytoFirewallStateMachine** value.
1. Click on **Start execution**.
1. In the **Input** field, replace with the contents from your local **aws-networkfirewall-guardduty/tests/securityhub-testevent.json** file.
1. Check your email to find a message about traffic that was automatically blocked.

### Review Provisioned Resources
* [AWS Network Firewall Rule Groups](https://console.aws.amazon.com/vpc/home?region=us-east-2#NetworkFirewallRuleGroups:)
* [AWS Lambda Application](https://us-east-2.console.aws.amazon.com/lambda/home?region=us-east-2#/applications/aws-5-mins-networkfirewall-guardduty)
* [Amazon EventBridge](https://us-east-2.console.aws.amazon.com/events/home?region=us-east-2#/rules)
* [AWS Step Functions](https://us-east-2.console.aws.amazon.com/states/home?region=us-east-2#/statemachines)


# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-networkfirewall-guardduty --region us-east-2
```

# Additional Resources

* [Automatically block suspicious traffic with AWS Network Firewall and Amazon GuardDuty](https://aws.amazon.com/blogs/security/automatically-block-suspicious-traffic-with-aws-network-firewall-and-amazon-guardduty/)
* [Example code](https://github.com/aws-samples/aws-networkfirewall-guardduty)
* [Deployment models for AWS Network Firewall](https://aws.amazon.com/blogs/networking-and-content-delivery/deployment-models-for-aws-network-firewall/)