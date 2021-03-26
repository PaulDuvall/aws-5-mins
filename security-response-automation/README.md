You can find the [5-minute video](https://youtu.be/wWewVior4t0) that walks through all of the steps described [here](https://youtu.be/wWewVior4t0).

In this episode, we'll be looking at security response automation. With it, you can proactively detect and respond to errors using automation rather than human intervention. This way you can spend more time on strengthening the layers of your security protection.

In the demo, I will walkthrough a solution from the AWS blog post called [Automatically block suspicious traffic with AWS Network Firewall and Amazon GuardDuty](https://aws.amazon.com/blogs/security/automatically-block-suspicious-traffic-with-aws-network-firewall-and-amazon-guardduty/) that uses [AWS Network Firewall](https://aws.amazon.com/network-firewall/), [Amazon GuardDuty](https://aws.amazon.com/guardduty/), [AWS Lambda](https://aws.amazon.com/lambda/), [AWS Security Hub](https://aws.amazon.com/security-hub/), [Amazon EventBridge](https://aws.amazon.com/eventbridge/), [AWS Step Functions](https://aws.amazon.com/step-functions/), and [Amazon VPC](https://aws.amazon.com/vpc/). It's launched via an [AWS CloudFormation](https://aws.amazon.com/cloudformation/) stack. The CloudFormation template defines resources that are automatically provisioned for the services I just listed.

In this scenario, Amazon GuardDuty is automatically running behavior checks like backdoors. It sends this event data to AWS Security Hub. These events are sent to Amazon EventBridge which filters this data and runs a Step Function state machine if it meets the pattern criteria. In this step function, it's entering data into a DynamoDB table and running a Lambda function that sends notifications and uses AWS Network Firewall to block traffic. In the demo, you'll be using a test event to mimic GuardDuty and Security Hub events to be detected by EventBridge.

With this approach, it can automatically detect and block suspicious network traffic without human intervention.

## Launch CloudFormation Stack

1. Launch a Cloud9 Environment in **us-east-2** using these [instructions](https://github.com/PaulDuvall/aws-5-mins/tree/main/cloud9). Be sure to change the `CHANGE-EMAIL-ADDRESS` token to your email address.

```
sudo rm -rf ~/environment/aws-networkfirewall-guardduty
git clone https://github.com/aws-samples/aws-networkfirewall-guardduty.git
cd aws-networkfirewall-guardduty/templates


aws cloudformation deploy \
--stack-name aws-5-mins-security-response-automation \
--template-file aws-networkfirewall-guardduty.template \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides AdminEmail=CHANGE-EMAIL-ADDRESS Retention=5 PruningFrequency=5 \
--no-fail-on-empty-changeset \
--region us-east-2
```

1. Go to the [CloudFormation Console](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks). It'll take about three minutes for the stack to launch.
1. While the stack is being created, be sure to confirm the email that's been sent to you from Amazon SNS. 
1. From your Cloud9 environment, open the file located at **aws-networkfirewall-guardduty/tests/securityhub-testevent.json**.
1. Around line 55, find the **eventLastSeen** field and edit the timestamp to the current time in the UTC+0 time zone. For example: `2021-03-24T12:00:01.549Z`.
1. Once the stack is **CREATE_COMPLETE**, review the [AWS Network Firewall Rule Groups](https://console.aws.amazon.com/vpc/home?region=us-east-2#NetworkFirewallRuleGroups:) configuration.
1. Then, go to the **Outputs** tab for the CloudFormation stack and click on the link for the **GuardDutytoFirewallStateMachine** value to open the state machine in the AWS Step Functions console.
1. Click on **Start execution**.
1. Replace the contents in the **Input** field of the Step Function execution pane with the contents from your local **aws-networkfirewall-guardduty/tests/securityhub-testevent.json** file.
1. Check your email to find a message about traffic that was automatically blocked.
1. Review the [AWS Network Firewall Rule Groups](https://console.aws.amazon.com/vpc/home?region=us-east-2#NetworkFirewallRuleGroups:) configuration again to see the changes made to the rule group.

### Review Other Provisioned Resources

* [AWS Lambda Application](https://us-east-2.console.aws.amazon.com/lambda/home?region=us-east-2#/applications/aws-5-mins-security-response-automation)
* [Amazon EventBridge](https://us-east-2.console.aws.amazon.com/events/home?region=us-east-2#/rules)

### Pruning of Old Records
1. After 5 minutes and from the [Step Functions Console](https://us-east-2.console.aws.amazon.com/states/home?region=us-east-2#/statemachines/), choose the state machine beginning with **PruningStateMachine** and view the graph.

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-security-response-automation --region us-east-2
```

# Additional Resources

* [Automatically block suspicious traffic with AWS Network Firewall and Amazon GuardDuty](https://aws.amazon.com/blogs/security/automatically-block-suspicious-traffic-with-aws-network-firewall-and-amazon-guardduty/)
* [Example code](https://github.com/aws-samples/aws-networkfirewall-guardduty)
* [Deployment models for AWS Network Firewall](https://aws.amazon.com/blogs/networking-and-content-delivery/deployment-models-for-aws-network-firewall/)