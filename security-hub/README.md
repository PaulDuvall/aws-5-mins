**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS Security Hub.

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack
1. From your [AWS CloudShell Environment](https://us-west-2.console.aws.amazon.com/cloudshell/home?region=us-west-2#) in the **us-west-2** region, run this command to launch the CloudFormation Stack:

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

There is one main CloudFormations stack and five nested stacks that get lauched. These nested stacks provision the Security Hub, Config, GuardDuty, Inspector, and Secrets Manager resources. It takes about 10 minutes for all of the CloudFormations stakcs to be created. After all the CloudFormation stacks are complete, go to the web consoles for Security Hub, Config, GuardDuty, Inspector, and Secrets Manager to see the resources that were created when launching the stacks as shown below. 

* Go to the [AWS CloudFormation Console](https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/) (search for the stacks beginning with `aws-5-mins-security-hub`). 
* Go to the [AWS Security Hub Console](https://us-west-2.console.aws.amazon.com/securityhub/) and click on the **Summary**, **Security standards**, **Insights**, **Findings**, and **Integrations** links.
* Go to the [AWS Config Console](https://us-west-2.console.aws.amazon.com/config/home?region=us-west-2) and click on the Conformance packs, Rules, Resources, Aggregators, Rules, Resources, Authorizations, Advanced queries, and Settings links.
* Go to the [Amazon GuardDuty Console](https://us-west-2.console.aws.amazon.com/guardduty/home?region=us-west-2#/).
* Go to the [Amazon Inspector Console](https://us-west-2.console.aws.amazon.com/inspector/home?region=us-west-2#/).
* Go to the [AWS Secrets Manager Console](https://us-west-2.console.aws.amazon.com/secretsmanager/home?region=us-west-2#).

# Deployment Pipeline

# Pricing
TBD

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME --region us-west-2
```

# Additional Resources