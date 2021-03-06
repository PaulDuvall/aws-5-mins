You can find the [5-minute video](https://youtu.be/Dg-rh17b91Q) that walks through all of the steps described here. 

# How it Works
[Amazon DevOps Guru](https://aws.amazon.com/devops-guru/) is a machine learning (ML) powered cloud operations service to improve application availability. As of January 2021, this service is currently in preview. 

![How it Works](https://github.com/PaulDuvall/aws-5-mins/blob/main/_img/devops-guru-howitworks.png)

The ML models that DevOps Guru uses are based on years of experience from Amazon running tens of thousands of applications at scale. DevOps Guru regularly looks for anomalous behavior such as increased latency, error rates, and resource constraints that could lead to possible service outages or disruptions. Since DevOps Guru can be run at all times, it can regularly report on anomalous behavior through its dashboard or notifications. It provides reactive and proactive Insights along with the mean time to recovery of CloudFormation stacks. 

For example, with [Proactive Insights](https://docs.aws.amazon.com/devops-guru/latest/userguide/understanding-insights-console.html), you can be made aware of issues such as memory utilization before they become a problem that affect your end users. Whereas there are numerous ways to assess the operational health of facets of your AWS Accounts (e.g., Config, CloudWatch, Trusted Advisor, and others).

DevOps Guru focuses on your application and infrastructure health by looking at how the applications are running in production. This diagram shows how Amazon DevOps Guru couples machine learning models with CloudWatch, Config, CloudTrail, X-Ray data to analyze the provisioned resources from selected CloudFormation stacks to provide recommendations.  

# Getting Started
The steps for using the [AWS Console](https://console.aws.amazon.com/codeguru/devops-guru/) to enable Amazon DevOps Guru are pretty straightforward. 
First, you choose the AWS resources you want to analyze, optionally select a SNS topic to receive operational notifications, and click the Enable button to start the service. 

After enabling it, DevOps Guru populates DevOps Guru dashboard that provides Insights to improve your application performance.

# CloudFormation Support
There are two DevOps Guru resources supported by AWS CloudFormation. They are [AWS::DevOpsGuru::NotificationChannel](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-devopsguru-notificationchannel.html) and [AWS::DevOpsGuru::ResourceCollection](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-devopsguru-resourcecollection.html). NotificationChannel allows you to set up an SNS channel to receive notifications on important DevOps Guru events. ResourceCollection defines a collection of supported resources that DevOps Guru will analyze for anomalous behavior. For example, a collection of CloudFormation stacks.

## Launch CloudFormation Stack

1. Launch a Cloud9 Environment in **us-east-1** using these [instructions](https://github.com/PaulDuvall/aws-5-mins/tree/main/cloud9).
1. Create an empty YAML file.

```
mkdir ~/environment/my-aws-5-mins
cd ~/environment/my-aws-5-mins
touch devops-guru.yml
```
1. Copy the contents from **[devops-guru.yml](https://raw.githubusercontent.com/PaulDuvall/aws-5-mins/main/devops-guru/devops-guru.yml)** to your local **devops-guru.yml** file in Cloud9 and save it. 
1. Run this command to launch a CloudFormation stack to enable DevOps Guru. 

```
aws cloudformation deploy \
--stack-name aws-5-mins-devops-guru \
--template-file devops-guru.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-1
```

It takes less than 1 minute to launch the [CloudFormation Stack](https://console.aws.amazon.com/cloudformation). You can visit the [DevOps Guru](https://console.aws.amazon.com/codeguru/devops-guru/) Console.

# Deployment Pipeline
You might have CodePipeline deploy a CloudFormation stack that provisions Amazon DevOps Guru for your region(s) using a CodePipeline CloudFormation Deploy Provider.

# Pricing
There are three pricing dimensions for DevOps Guru. Currently, DevOps Guru charges $0.0028/hour for Lambda Functions and S3 buckets and $0.0042/hour for the remaining resources such as EC2 instances, ECS Service, and ELB. You also pay $0.000040 for each DevOps Guru API call (e.g. DescribeAccountOverview, ListInsights). This translates to $0.40 for 10K API calls. See Amazon DevOps Guru Pricing for more details.

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-devops-guru
```