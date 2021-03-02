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
2. Complete the required application settings
* **Application name**: Enter `aws-5-mins-automated-iam-policy-alerts-approvals`.
* **EmailAddress**: an administrator's email address for receiving approval requests.
* **restrictedActions**: the IAM Policy actions you want to restrict.
3. Choose **Deploy**.
Once the deployment process is completed, 21 new resources are created. This includes:

* Five Lambda functions that contain the business logic.
* An [Amazon EventBridge](https://aws.amazon.com/eventbridge/) rule.
* An [Amazon SNS](https://aws.amazon.com/sns/) topic and subscription.
* An [Amazon API Gateway](https://aws.amazon.com/api-gateway/) REST API with two resources.
* An AWS Step Functions state machine
* To receive Amazon SNS notifications as the application administrator, you must confirm the subscription to the SNS topic. To do this, choose the **Confirm subscription** link in the verification email that was sent to you when deploying the application.
* Once the **serverlessrepo-aws-5-mins-*** [AWS CloudFormation stack](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/) is **CREATE_COMPLETE**, from your [AWS CloudShell Environment](https://us-east-1.console.aws.amazon.com/cloudshell/home?region=us-east-1#) in the **us-east-1** region, run the following commands: 

```
aws iam create-policy --policy-name my-bad-policy-aws-5-mins --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketObjectLockConfiguration",
                "s3:DeleteObjectVersion",
                "s3:DeleteBucket"
            ],
            "Resource": "*"
        }
    ]
}'
```

* Go to the [IAM policy](https://console.aws.amazon.com/iam/home?region=us-east-1#/policies) you just created to view the definition. 
* Go to the [AWS Step Functions Console](https://console.aws.amazon.com/states/home?region=us-east-1#/statemachines).
* Go to [Amazon API Gateway Console](https://console.aws.amazon.com/apigateway/home?region=us-east-1#/apis/). Choose **Stages** and then **Prod**. Copy the **Invoke URL** link and paste to your clipboard. 
* Go to the [AWS Step Functions Console](https://console.aws.amazon.com/states/home?region=us-east-1#/statemachines/) and choose the State Machine. Then scroll down to the **TaskSubmitted** Type of the **AskUser** step.
* Copy the **token** value and append it to the URL as shown:

* `API_GATEWAY_URL/allow?token=TOKEN_FROM_STEP_FUNCTION_STEP` - To revert to the original IAM policy definition.
* `API_GATEWAY_URL/deny?token=TOKEN_FROM_STEP_FUNCTION_STEP` - To keep the automatically remediated IAM policy definition in place.

* Now, open your browser and paste the URL from above and submit.
* Go to the [IAM policy](https://console.aws.amazon.com/iam/home?region=us-east-1#/policies) view the definition based on your updates.  
* Go to the [AWS Step Functions Console](https://console.aws.amazon.com/states/home?region=us-east-1#/statemachines/). The status for the state machine should be **Succeeded**.


# Pricing
For the standard workflow and after 4,000 state transitions per month, you pay $0.025 per 1,000 state transitions. For more information, see [AWS Step Functions Pricing](https://aws.amazon.com/step-functions/pricing/) . 

# Delete Resources


1. Go to the [IAM policy](https://console.aws.amazon.com/iam/home?region=us-east-1#/policies) and delete `my-bad-policy-aws-5-mins`. 
1. From your [AWS CloudShell Environment](https://us-east-1.console.aws.amazon.com/cloudshell/home?region=us-east-1#) in the **us-east-1** region, run the following command: 

```
aws cloudformation delete-stack --stack-name serverlessrepo-aws-5-mins-automated-iam-policy-alerts-approval
```

# Additional Resources

* [Orchestrating a security incident response with AWS Step Functions](https://aws.amazon.com/blogs/compute/orchestrating-a-security-incident-response-with-aws-step-functions/)