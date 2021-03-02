**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at [AWS Step Functions](https://aws.amazon.com/step-functions/). With Step Functions you can orchestratre serverless functions and manual activities into an end-to-end workflow. It provides a "State Machine as a Service". 

There is a visual interface and you can define the states using the [Amazon States Language](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-amazon-states-language.html) (ASL). The ASL is a JSON-based, structured language used to define your state machine, or collection of states, that can do work (Task states), determine which states to transition to next (Choice states), stop an execution with an error (Fail states), and so on. The output of one step acts as an input to the next. Each step in your application executes in order, as defined by your business logic.

For example, without Step Functions, you might have a series of individual serverless applications and manage retries and debugging failures can be challenging. As your distributed applications become more complex, the complexity of managing them also grows. Step Functions automatically manages sequencing, error handling, retry logic, and state. It can remove many of the operational burdens from your team.

In the demo, I use Step Functions to track and resolve a security incident in which Step Functions identifies the problem and then orchestrates manual and automated actions until it's resolved.

# CloudFormation
* [AWS::StepFunctions::StateMachine](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-statemachine.html) - Defines the steps in your state machine.
* [AWS::StepFunctions::Activity](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-stepfunctions-activity.html) - Defines how the task in your state machine is performed - whether it's EC2, ECS, mobile devices, etc.

## Launch CloudFormation Stack

Run the following steps to launch resources that create an AWS Step Function State Machine and associated resources. The steps below are taken from this [blog post](https://aws.amazon.com/blogs/compute/orchestrating-a-security-incident-response-with-aws-step-functions/).

1. Deploy the application from the Serverless Application Repository
Find the [Automated-IAM-policy-alerts-and-approvals](https://console.aws.amazon.com/lambda/home?region=us-east-1#/create/app?applicationId=arn:aws:serverlessrepo:us-east-1:981723798357:applications/Automated-IAM-policy-alerts-and-approvals) app in the Serverless Application Repository.
1. Complete the required application settings
* **Application name**: Enter `aws-5-mins-automated-iam-policy-alerts-approvals`.
* **EmailAddress**: an administrator's email address for receiving approval requests.
* **restrictedActions**: the IAM Policy actions you want to restrict.
1. Choose **Deploy**.
Once the deployment process is completed, 21 new resources are created. This includes:

* Five Lambda functions that contain the business logic.
* An Amazon EventBridge rule.
* An Amazon SNS topic and subscription.
* An Amazon API Gateway REST API with two resources.
* An AWS Step Functions state machine
* To receive Amazon SNS notifications as the application administrator, you must confirm the subscription to the SNS topic. To do this, choose the **Confirm subscription** link in the verification email that was sent to you when deploying the application.

# Pricing
For the standard workflow and after 4,000 state transitions per month, you pay $0.025 per 1,000 state transitions. For more information, see [AWS Step Functions Pricing](https://aws.amazon.com/step-functions/pricing/) . 

# Delete Resources

1. From your [AWS CloudShell Environment](https://us-east-1.console.aws.amazon.com/cloudshell/home?region=us-east-1#) in the **us-east-1** region, run the following commands: 

```
aws cloudformation delete-stack --stack-name aws-5-mins-automated-iam-policy-alerts-approvals
```

# Additional Resources

* [Orchestrating a security incident response with AWS Step Functions](https://aws.amazon.com/blogs/compute/orchestrating-a-security-incident-response-with-aws-step-functions/)