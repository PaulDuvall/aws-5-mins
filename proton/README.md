**NOTE: This video has not been released yet.**

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

1. Launch a [CloudShell Environment](https://us-west-2.console.aws.amazon.com/cloudshell/home?region=us-west-2) in **us-west-2** and follow the instructions below. These instructions and scripts are based on https://github.com/relaxdiego/aws-lab/tree/main/proton. 

```
git clone https://github.com/PaulDuvall/aws-lab.git
cd aws-lab

proton/create-prerequisites.sh
proton/create-environment-template.sh
proton/create-service-template.sh
```

Update your [CodeStar Connection](https://us-west-2.console.aws.amazon.com/codesuite/settings/connections).


Run the commands below to create a Proton Environment.

```
git clone https://github.com/aws-samples/aws-proton-sample-templates

cd aws-proton-sample-templates/loadbalanced-fargate-svc

aws proton-preview create-environment \
  --region us-west-2 \
  --environment-name "Beta" \
  --environment-template-arn arn:aws:proton:us-west-2:${account_id}:environment-template/public-vpc \
  --template-major-version-id 1 \
  --proton-service-role-arn arn:aws:iam::${account_id}:role/ProtonServiceRole \
  --spec file://specs/env-spec.yaml
  
aws proton-preview wait environment-deployment-complete \
  --region us-west-2 \
  --environment-name "Beta"

```

Update your AWS CodeStar [Connection](https://us-west-2.console.aws.amazon.com/codesuite/settings/connections?region=us-west-2) to ensure it's connected GitHub to AWS.

Run the command below replacing `<your-codestar-connection-id>` with the id from the link above. You also need to replace the `<your-source-repo-account>/<your-repository-name>` with the appropriate values for your GitHub account and repository names.

```
aws proton-preview create-service \
  --region us-west-2 \
  --service-name "front-end" \
  --repository-connection-arn arn:aws:codestar-connections:us-west-2:${account_id}:connection/<your-codestar-connection-id> \
  --repository-id "<your-source-repo-account>/<your-repository-name>" \
  --branch "main" \
  --template-major-version-id 1 \
  --service-template-arn arn:aws:proton:us-west-2:${account_id}:service-template/lb-fargate-service \
  --spec file://specs/svc-spec.yaml
  
aws proton-preview wait service-creation-complete \
  --region us-west-2 \
  --service-name "front-end"

```

Once the service is created, retrieve the CodePipeline pipeline console URL and the CRUD API endpoint URL for your service.

```
aws proton-preview get-service \
  --region us-west-2 \
  --service-name "front-end" \
  --query "service.pipeline.outputs" \
  --output text

aws proton-preview get-service-instance \
  --region us-west-2 \
  --service-name "front-end" \
  --service-instance-name "frontend-dev" \
  --query "serviceInstance.outputs" \
  --output text

```

## Review Resources Proton Created

1. Review the [CodePipeline pipeline](https://us-west-2.console.aws.amazon.com/codesuite/codepipeline/pipelines?region=us-west-2).
1. Review the [CloudFormation stacks](https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks?filteringText=proton&filteringStatus=active&viewNested=true&hideStacks=false&stackId=) that Proton provisions. 
1. Review the [Proton Environment](https://us-west-2.console.aws.amazon.com/proton/home?region=us-west-2#/environments/detail/Beta) and [Environment Template](https://us-west-2.console.aws.amazon.com/proton/home?region=us-west-2#/templates/environments/detail/public-vpc).
1. Review the [Proton Service](https://us-west-2.console.aws.amazon.com/proton/home?region=us-west-2#/services/detail/front-end) and [Service Template](https://us-west-2.console.aws.amazon.com/proton/home?region=us-west-2#/templates/services/detail/lb-fargate-service).

There's currently no CloudFormation support but, presumably, when the service is generally available, it will be included.

# Pricing
There is no additional charge for AWS Proton. You pay for AWS resources you create to store and run your application. There are no minimum fees and no upfront commitments. You pay for the resources that are provisioned through Proton such as S3 buckets, EC2 instances, containers, etc. 

# Delete Resources

1. Delete the `front-end` service you launched using this link: [Delete Service](https://us-west-2.console.aws.amazon.com/proton/home?region=us-west-2#/services/detail/front-end). The Proton console does not always show the correct status, so run `aws proton-preview list-services --region us-west-2` from your [CloudShell Environment](https://us-west-2.console.aws.amazon.com/cloudshell/home?region=us-west-2) to verify that the service has been removed. It can take over 5 minutes before all resources associcated with the service are deleted.  
1. Delete the `Beta` environment you launched using this link: [Delete Environment](https://us-west-2.console.aws.amazon.com/proton/home?region=us-west-2#/environments/detail/Beta). The Proton console does not currently show the correct status, so run this command: `aws proton-preview list-environments --region us-west-2` from your [CloudShell Environment](https://us-west-2.console.aws.amazon.com/cloudshell/home?region=us-west-2) to verify it's been removed. 
1. Delete local directories and S3 bucket used to store Proton files from your [CloudShell Environment](https://us-west-2.console.aws.amazon.com/cloudshell/home?region=us-west-2) as shown below. 
```
git clone https://github.com/PaulDuvall/aws-lab.git
cd aws-lab

aws s3api list-buckets --query 'Buckets[?starts_with(Name, `proton-cli-templates-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

proton/delete-everything.sh

sudo rm -rf ~/aws-proton-sample-templates
sudo rm -rf  ~/aws-lab
cd ~
```
Perform the following commands from your [CloudShell Environment](https://us-west-2.console.aws.amazon.com/cloudshell/home?region=us-west-2).

1. Verify the `lb-fargate-service` Proton service template has been removed using this command: `aws proton-preview list-service-templates --region us-west-2`.
1. Verify the `public-vpc` Proton enviroment template has been removed using this command: `aws proton-preview list-environment-templates --region us-west-2`.
1. Verify there is no IAM Role named `ProtonServiceRole`using this command: `aws iam delete-role --role-name ProtonServiceRole`. You should received the following error message: `An error occurred (NoSuchEntity) when calling the DeleteRole operation: The role with name ProtonServiceRole cannot be found.`.
1. Verify that the Linked Account Rolese have been deleted by going to [Proton Account roles](https://us-west-2.console.aws.amazon.com/proton/home?region=us-west-2#/settings/roles).
1. Delete the [CodeStar Connection](https://us-west-2.console.aws.amazon.com/codesuite/settings/connections?region=us-west-2). 