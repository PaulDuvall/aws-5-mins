**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS Security Hub.

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack
1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run this command to launch the CloudFormation Stack:

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
--region us-east-2
```


# Deployment Pipeline

# Pricing
TBD

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME --region us-east-2
```

# Additional Resources