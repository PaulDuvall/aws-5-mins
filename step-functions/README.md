**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS Step Functions.

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

Run the following steps to launch resources that create an AWS Step Function State Machine and associated resources.

1. Deploy the application from the Serverless Application Repository
Find the [Automated-IAM-policy-alerts-and-approvals](https://console.aws.amazon.com/lambda/home?region=us-east-1#/create/app?applicationId=arn:aws:serverlessrepo:us-east-1:981723798357:applications/Automated-IAM-policy-alerts-and-approvals) app in the Serverless Application Repository.
1. Complete the required application settings
* **Application name**: an identifiable name for the application.
* **EmailAddress**: an administrator’s email address for receiving approval requests.
* **restrictedActions**: the IAM Policy actions you want to restrict.

1. From your [AWS CloudShell Environment](https://us-east-1.console.aws.amazon.com/cloudshell/home?region=us-east-1#) in the **us-east-1** region, run the following commands: 

```
aws serverlessrepo create-cloud-formation-change-set \
--application-id arn:aws:serverlessrepo:us-east-1:981723798357:applications/ \
--stack-name aws-5-mins-security-incident-response \
--capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND --region us-east-1

aws cloudformation execute-change-set \
--change-set-name changeset-id-arn --region us-east-1
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