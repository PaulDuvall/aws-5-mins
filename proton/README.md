In this episode, we'll be looking at AWS Proton.

![How it Works](https://github.com/PaulDuvall/aws-5-mins/blob/main/_img/proton-how-it-works.png)

# How it Works
[AWS Proton](https://aws.amazon.com/proton/) provides automated management for container and serverless deployments. With Proton, you can manage your infrastructure so developers can focus on coding.

AWS mentions that Proton can be used by "…Platform engineering teams…to connect and coordinate all the different tools needed for infrastructure provisioning, code deployments, monitoring, and updates."

Proton provides the ability to create pre-baked deployment patterns via templates. It's geared towards enterprise teams that might have a “platform team” (there are many other names for these centralized teams in enterprises) that provide common patterns for deployment of serverless and container-based applications for many teams. 

Proton helps customers define templates that create the structure for applying common deployment patterns using existing AWS services such as AWS CodePipeline, AWS Service Catalog, and AWS CloudFormation – among what will be many other service integrations. These templates define how deployments behave across multiple teams. 

# Getting Started
These are the four steps for launching environments and/or services using the AWS Proton Console.

1. Create Proton templates (environment and/or service).
1. Set up for using Proton (e.g., creating an IAM Role).
1. Create and deploy an environment based on an environment template.
1. Create and deploy a service based on a service template. You deploy a service into an environment, which itself is based on a common template. 

An environment defines a set of shared resources and policies that apply to all of the services deployed to it. A service defines how your application is run within an environment

# CLI
Since AWS Proton is still in preview, you need to install the Proton APIs in order to run commands. For this example, I am using the **us-east-2** region. 

1. Create a [Connection](https://us-east-2.console.aws.amazon.com/codesuite/settings/connections) using AWS Developer Tools. 
1. Click **Create connection**.
1. Select **GitHub**.
1. Enter `https://github.com/brentley/ecsdemo-frontend`. 
1. Go back to Cloud9 and clone the example template repo from AWS using this command. 

```
git clone https://github.com/aws-samples/aws-proton-sample-templates.git
```

1. Run through the commands for installing the Proton APIs and launching Proton from the commands listed in the [AWS Proton: A first look](https://aws.amazon.com/blogs/containers/intro-to-aws-proton/) blog post.
2. After completing the commands from the blog post, go to the [AWS Proton](https://console.aws.amazon.com/proton/) Console.

AWS has provided example proton templates at [aws-proton-sample-templates](https://github.com/aws-samples/aws-proton-sample-templates).

There's currently no CloudFormation support but, hopefully, when the service is generally available, it will be included. Once installed, you can run the following command similar to this snippet to create an environment template using Proton.

# Pricing
There is no additional charge for AWS Proton. You pay for AWS resources you create to store and run your application. There are no minimum fees and no upfront commitments. You pay for the resources that are provisioned through Proton such as S3 buckets, EC2 instances, containers, etc. 
