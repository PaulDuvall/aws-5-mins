**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at TBD

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

Run the following steps to launch resources that run a canary test with Synthetics.

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```
aws serverlessrepo create-cloud-formation-change-set \
--application-id arn:aws:serverlessrepo:us-east-1:981723798357:applications/ \
--stack-name aws-5-mins-security-incident-response \
--capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND --region us-east-2

aws cloudformation execute-change-set \
--change-set-name changeset-id-arn --region us-east-2
```


# Deployment Pipeline

# Pricing
TBD

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME
```

# Additional Resources

* [Orchestrating a security incident response with AWS Step Functions](https://aws.amazon.com/blogs/compute/orchestrating-a-security-incident-response-with-aws-step-functions/)