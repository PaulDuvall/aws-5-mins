**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at [Amazon GuardDuty](https://aws.amazon.com/guardduty/). GuardDuty @todo


# CloudFormation Support
* AWS::GuardDuty::Detector
* AWS::GuardDuty::Filter
* AWS::GuardDuty::IPSet
* AWS::GuardDuty::Master
* AWS::GuardDuty::Member
* AWS::GuardDuty::ThreatIntelSet

## Launch CloudFormation Stack
1. From your [AWS CloudShell Environment](https://us-west-2.console.aws.amazon.com/cloudshell/home?region=us-west-2#) in the **us-west-2** region, run the commands below to launch the main CloudFormation Stack:

```
sudo rm -rf ~/aws-security-hub-workshop
git clone https://github.com/aws-samples/aws-security-hub-workshop.git
cd ~/aws-security-hub-workshop/templates
```

```
aws cloudformation deploy \
--stack-name aws-5-mins-sh-guardduty \
--template-file sechub-workshop-setup-template.json  \
--capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND \
--parameter-overrides EnableGuardDuty="Yes-Enable GuardDuty" \
EnableSecurityHub="Yes-Enable Security Hub" EnableConfig="Yes-Enable Config" \
--no-fail-on-empty-changeset \
--region us-west-2
```

There is one main CloudFormations stack and five nested stacks that get launched. These nested stacks provision the Security Hub, Config, GuardDuty, Inspector, and Secrets Manager resources. It takes about 4 minutes for all of the CloudFormations stacks to be created. After all the CloudFormation stacks are complete, go to the web consoles for Security Hub, Config, GuardDuty, Inspector, and Secrets Manager to see the resources that were created when launching the stacks as shown below. 

* Go to the [AWS CloudFormation Console](https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/) (search for the stacks beginning with `aws-5-mins-sh-guardduty`). 
* Go to the [Amazon GuardDuty Console](https://us-west-2.console.aws.amazon.com/guardduty/home?region=us-west-2#/).

# Pricing
* AWS CloudTrail Management Event Analysis $4.00 per 1 million events per month
* AWS CloudTrail S3 Data Event Analysis	$0.80 per 1 million events. Past 500 million events per month, this price reduces. 
* VPC Flow Log and DNS Log Analysis	$1.00 per GB. Past 500 GB per month, this price reduces.

For more information, see [Amazon GuardDuty Pricing](https://aws.amazon.com/guardduty/pricing/).

# Delete Resources

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `aws-5-mins-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force


aws cloudformation delete-stack --stack-name aws-5-mins-sh-guardduty --region us-west-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-sh-guardduty --region us-west-2

```

# Additional Resources
