**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at [AWS Security Hub](https://aws.amazon.com/security-hub/). AWS Security Hub integrates, aggregates, and distill controls from other AWS security services and 3rd party providers. It presents this information through a dashboard and can emit events that can be consumed by external providers.

Security Hub presents findings and insights. Findings are based on security checks that verify security compliance by running services such as AWS Config Rules and 3rd party providers. These security checks are based on controls defined by security standards. AWS Security Hub provides built-in security standards from [AWS](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-standards-fsbp-controls.html), [CIS](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-cis-controls.html), and [PCI-DSS](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-pci-controls.html). There are managed and custom security checks. Security Hub aggregates security checks into Managed Insights that help identify trends. You can also create custom Insights based on your requirements.

Security Hub integrates with AWS Audit Manager, Amazon Detective, AWS Firewall Manager, Amazon GuardDuty, IAM Access Analyzer, Amazon Inspector, Amazon Macie, and AWS Systems Manager Patch Manager. It also integrates with [3rd party providers](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-partner-providers.html) using the AWS Security Finding Format [ASFF](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-findings-format.html). 

Some customers might use Security Hub as a lightweight Security information and event management (SIEM) tool for their AWS workloads while others might integrate it with existing SIEMs such as Splunk or Datadog. For example, an enterprise customer might use Security Hub to run AWS security controls and route nonremediated issues to Splunk in which the remediation workflow via something like PagerDuty. 

# CloudFormation Support
* [AWS::SecurityHub::Hub](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-securityhub-hub.html) - Enables the AWS Security Hub service for an AWS Region in your AWS account. 

## Launch CloudFormation Stack
1. From your [AWS CloudShell Environment](https://us-west-2.console.aws.amazon.com/cloudshell/home?region=us-west-2#) in the **us-west-2** region, run the commands below to launch the main CloudFormation Stack:

```
sudo rm -rf ~/aws-security-hub-workshop
git clone https://github.com/aws-samples/aws-security-hub-workshop.git
cd ~/aws-security-hub-workshop/templates
```

```
aws cloudformation deploy \
--stack-name aws-5-mins-security-hub \
--template-file sechub-workshop-setup-template.json  \
--capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND \
--parameter-overrides EnableGuardDuty="Yes-Enable GuardDuty" \
EnableSecurityHub="Yes-Enable Security Hub" EnableConfig="Yes-Enable Config" \
--no-fail-on-empty-changeset \
--region us-west-2
```

There is one main CloudFormation stack and five nested stacks that get launched. These nested stacks provision the Security Hub, Config, GuardDuty, Inspector, and Secrets Manager resources. It takes about **4 minutes** for all of the CloudFormation stacks to be created. After all the CloudFormation stacks are complete, go to the web consoles for Security Hub, Config, GuardDuty, Inspector, and Secrets Manager to see the resources that were created when launching the stacks as shown below. 

* Go to the [AWS CloudFormation Console](https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/) (search for the stacks beginning with `aws-5-mins-security-hub`). 
* Go to the [AWS Security Hub Console](https://us-west-2.console.aws.amazon.com/securityhub/) and click on the **Summary**, **Security standards**, **Insights**, **Findings**, and **Integrations** links.

# Pricing
There are two pricing dimensions for Security Hub - security checks and finding ingestion events. For security checks, AWS charges $0.0010 for the first 100,000 checks per account/region/month. For finding ingestion events, there is no charge until there are over 10,000 events/account/region/month and then it's $0.00003 per event. For more information, see the [AWS Security Hub Pricing](https://aws.amazon.com/security-hub/pricing/) page.

# Delete Resources

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `aws-5-mins-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force


aws cloudformation delete-stack --stack-name aws-5-mins-security-hub --region us-west-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-security-hub --region us-west-2

```

# Additional Resources
[AWS Podcast #408: AWS Foundational Security Best Practices using AWS Security Hub](https://www.amazon.com/408-Foundational-Security-Practices-using/dp/B08KN2LXCJ)