In this episode, we'll be looking at AWS Proton.

![How it Works](https://github.com/PaulDuvall/aws-5-mins/blob/main/_img/proton-how-it-works.png) [Source](https://aws.amazon.com/proton/)

# How it Works
[AWS Proton](https://aws.amazon.com/proton/) provides automated management for container and serverless deployments. With Proton, you can manage your infrastructure so developers can focus on coding.

AWS mentions that Proton can be used by "…Platform engineering teams…to connect and coordinate all the different tools needed for infrastructure provisioning, code deployments, monitoring, and updates."

Proton provides the ability to create pre-baked deployment patterns via templates. It's geared towards enterprise teams that might have a “platform team” (there are many other names for these centralized teams in enterprises) that provide common patterns for deployment of serverless and container-based applications for many teams. 

Proton helps customers define templates that create the structure for applying common deployment patterns using existing AWS services such as AWS CodePipeline, AWS Service Catalog, and AWS CloudFormation – among what will be many other service integrations. These templates define how deployments behave across multiple teams. 

![Proton Features](https://github.com/PaulDuvall/aws-5-mins/blob/main/_img/proton-features.png) [Source](https://virtual.awsevents.com/media/1_4y7w5alh)

# Getting Started
These are the four steps for launching environments and/or services using the [AWS Proton Console](https://console.aws.amazon.com/proton/).

1. Create Proton templates (environment and/or service).
1. Set up for using Proton (e.g., creating an IAM Role).
1. Create and deploy an environment based on an environment template.
1. Create and deploy a service based on a service template. You deploy a service into an environment, which itself is based on a common template. 

An environment defines a set of shared resources and policies that apply to all of the services deployed to it. A service defines how your application is run within an environment

# CLI
Since AWS Proton is still in preview, you need to install the Proton APIs in order to run commands. For this example, I am using the **us-west-2** region. 

1. Launch a [CloudShell Environment](https://us-west-2.console.aws.amazon.com/cloudshell/home?region=us-west-2) in **us-west-2**.
1. Fork the [https://github.com/aws-samples/aws-proton-sample-templates](https://github.com/aws-samples/aws-proton-sample-templates) GitHib repository.
```
cd ~/
git clone https://github.com/aws-samples/aws-proton-sample-templates.git
cd aws-proton-sample-templates
```
1. Follow these [sample instructions](https://github.com/aws-samples/aws-proton-sample-templates/tree/main/loadbalanced-fargate-svc) from AWS to launch a ELB-backed Fargate service using AWS Proton. 
1. Review the [CodePipeline pipeline](https://us-west-2.console.aws.amazon.com/codesuite/codepipeline/pipelines) and [CloudFormation stacks](https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks?filteringText=proton&filteringStatus=active&viewNested=true&hideStacks=false&stackId=) that Proton provisions. 

There's currently no CloudFormation support but, presumably, when the service is generally available, it will be included. Once installed, you can run the following command similar to this snippet to create an environment template using Proton.

# Pricing
There is no additional charge for AWS Proton. You pay for AWS resources you create to store and run your application. There are no minimum fees and no upfront commitments. You pay for the resources that are provisioned through Proton such as S3 buckets, EC2 instances, containers, etc. 

# Delete Resources

1. Delete the `front-end` service you launched using this link: [Delete Service](https://us-west-2.console.aws.amazon.com/proton/home?region=us-west-2#/services/detail/front-end). The Proton console does not currently show the correct status, so run `aws proton-preview list-services --region us-west-2` to verify that the service has been removed. 
1. Delete the `Beta` environment you launched using this link: [Delete Environment](https://us-west-2.console.aws.amazon.com/proton/home?region=us-west-2#/environments/detail/Beta). The Proton console does not currently show the correct status, so run this command: `aws proton-preview list-environments --region us-west-2` to verify it's been removed. 
1. Delete the `lb-fargate-service` service template: [Delete Service Template](https://us-west-2.console.aws.amazon.com/proton/home?region=us-west-2#/templates/services/detail/lb-fargate-service). Verify the `lb-fargate-service` Proton service templates has been removed using this command: `aws proton-preview list-service-templates --region us-west-2`.
1. Delete the `public-vpc` environment template: [Delete Environment Template](https://us-west-2.console.aws.amazon.com/proton/home?region=us-west-2#/templates/environments/detail/public-vpc). Verify the `public-vpc` Proton enviroment template has been removed using this command: `aws proton-preview list-environment-templates --region us-west-2`.
1. Delete the `aws-5-mins-proton-service-role` IAM Role: [Delete IAM Role](https://console.aws.amazon.com/iam/home?region=us-east-1#/roles/ProtonServiceRole). Verify there is no IAM Role named `ProtonServiceRole`using this command: `aws iam delete-role --role-name ProtonServiceRole`