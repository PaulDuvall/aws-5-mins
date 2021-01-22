In this episode, we'll be looking at AWS Proton. 

AWS Proton provides automated management for container and serverless deployments. As of January 2021, it is in general preview. With Proton, you can manage your infrastructure so developers can focus on coding.

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
Since AWS Proton is still in preview, you need to install the Proton APIs in order to run commands. You will:

1. Set up an Amazon S3 bucket
1. Set up a GitHub repository connection
1. Install the AWS CLI Proton API

The steps for installing the Proton APIs to run the CLI are documented in this [blog post](https://aws.amazon.com/blogs/containers/intro-to-aws-proton/). There's currently no CloudFormation support but, hopefully, when the service is generally available, it will be included. Once installed, you can run the following command similar to this snippet to create an environment template using Proton.

```
aws proton-preview \
  --endpoint-url https://proton.us-east-2.amazonaws.com \
  --region us-east-2 \
  create-environment-template \
  --template-name "proton-example-dev-env" \
  --display-name "ProtonExampleDevVPC" \
  --description "Proton Example Dev VPC with Public Access and ECS Cluster”
```

AWS has provided example proton templates at aws-proton-sample-templates (see https://github.com/aws-samples/aws-proton-sample-templates).

**Pricing**
There is no additional charge for AWS Proton. You pay for AWS resources you create to store and run your application. There are no minimum fees and no upfront commitments. You pay for the resources that are provisioned through Proton such as S3 buckets, EC2 instances, containers, etc. 
