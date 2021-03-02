**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS Step Functions.

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

Run the following steps to launch resources that create an AWS Step Function State Machine and associated resources. The steps below are taken from this [blog post](https://aws.amazon.com/blogs/compute/orchestrating-a-security-incident-response-with-aws-step-functions/).

1. Deploy the application from the Serverless Application Repository
Find the [Automated-IAM-policy-alerts-and-approvals](https://console.aws.amazon.com/lambda/home?region=us-east-1#/create/app?applicationId=arn:aws:serverlessrepo:us-east-1:981723798357:applications/Automated-IAM-policy-alerts-and-approvals) app in the Serverless Application Repository.
1. Complete the required application settings
* **Application name**: Enter `aws-5-mins-automated-iam-policy-alerts-approvals`.
* **EmailAddress**: an administrator’s email address for receiving approval requests.
* **restrictedActions**: the IAM Policy actions you want to restrict.
1. Choose Deploy.
Once the deployment process is completed, 21 new resources are created. This includes:

* Five Lambda functions that contain the business logic.
* An Amazon EventBridge rule.
* An Amazon SNS topic and subscription.
* An Amazon API Gateway REST API with two resources.
* An AWS Step Functions state machine
* To receive Amazon SNS notifications as the application administrator, you must confirm the subscription to the SNS topic. To do this, choose the **Confirm subscription** link in the verification email that was sent to you when deploying the application.

# Pricing
TBD

# Delete Resources

1. From your [AWS CloudShell Environment](https://us-east-1.console.aws.amazon.com/cloudshell/home?region=us-east-1#) in the **us-east-1** region, run the following commands: 

```
aws cloudformation delete-stack --stack-name aws-5-mins-automated-iam-policy-alerts-approvals
```

# Additional Resources

* [Orchestrating a security incident response with AWS Step Functions](https://aws.amazon.com/blogs/compute/orchestrating-a-security-incident-response-with-aws-step-functions/)