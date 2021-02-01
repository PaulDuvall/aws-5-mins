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
Since AWS Proton is still in preview, you need to install the Proton APIs in order to run commands. For this example, I am using the **us-east-2** region. 

1. Launch a [CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2) in **us-east-2**.
1. Create a [Connection](https://us-east-2.console.aws.amazon.com/codesuite/settings/connections) using AWS Developer Tools. 
1. Click **Create connection**.
1. Select **GitHub**.
1. Enter `https://github.com/brentley/ecsdemo-frontend`. 
1. Go back to your CloudShell environment and clone the example template repo from AWS using these commands: 

```
cd ~/
git clone https://github.com/aws-samples/aws-proton-sample-templates.git
cd aws-proton-sample-templates
```

1. Run through the commands below to launch Proton resources. These are based on the blog post from AWS - [AWS Proton: A first look](https://aws.amazon.com/blogs/containers/intro-to-aws-proton/).

```
cd ~/
account_id=$(aws sts get-caller-identity --output text --query Account)

aws s3 cp s3://aws-proton-preview-public-files/model/proton-2020-07-20.normal.json .
aws s3 cp s3://aws-proton-preview-public-files/model/waiters2.json .
aws configure add-model --service-model file://proton-2020-07-20.normal.json --service-name proton-preview
mv waiters2.json ~/.aws/models/proton-preview/2020-07-20/waiters-2.json
rm proton-2020-07-20.normal.json

aws s3api create-bucket --bucket "proton-cli-templates-${account_id}" --region us-east-1

cd ~/aws-proton-sample-templates/loadbalanced-fargate-svc/

aws iam create-role --role-name aws-5-mins-proton-service-role --assume-role-policy-document file://./policies/proton-service-assume-policy.json

aws iam attach-role-policy --role-name aws-5-mins-proton-service-role --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

aws proton-preview \
  --endpoint-url https://proton.us-east-2.amazonaws.com \
  --region us-east-2 \
  update-account-roles \
  --account-role-details "pipelineServiceRoleArn=arn:aws:iam::${account_id}:role/aws-5-mins-proton-service-role"
  
aws proton-preview \
  --endpoint-url https://proton.us-east-2.amazonaws.com \
  --region us-east-2 \
  create-environment-template \
  --template-name "aws-5-mins-proton-dev-env" \
  --display-name "aws-5-mins-proton-dev-vpc" \
  --description "Proton Example Dev VPC with Public Access and ECS Cluster"
  
 aws proton-preview \
  --endpoint-url https://proton.us-east-2.amazonaws.com \
  --region us-east-2 \
  create-environment-template-major-version \
  --template-name "aws-5-mins-proton-dev-env" \
  --description "Version 1"
 
tar -zcvf env-template.tar.gz . && aws s3 cp env-template.tar.gz s3://proton-cli-templates-${account_id}/env-template.tar.gz && rm env-template.tar.gz

aws proton-preview \
  --endpoint-url https://proton.us-east-2.amazonaws.com \
  --region us-east-2 \
  create-environment-template-minor-version \
  --template-name "aws-5-mins-proton-dev-env" \
  --description "Proton Example Dev Environment Version 1" \
  --major-version-id "1" \
  --source-s3-bucket proton-cli-templates-${account_id} \
  --source-s3-key env-template.tar.gz

aws proton-preview \
  --endpoint-url https://proton.us-east-2.amazonaws.com \
  --region us-east-2 \
  wait environment-template-registration-complete \
  --template-name "aws-5-mins-proton-dev-env" \
  --major-version-id "1" \
  --minor-version-id "0"
  
 aws proton-preview \
  --endpoint-url https://proton.us-east-2.amazonaws.com \
  --region us-east-2 \
  update-environment-template-minor-version \
  --template-name "aws-5-mins-proton-dev-env" \
  --major-version-id "1" \
  --minor-version-id "0" \
  --status "PUBLISHED"
  
aws proton-preview \
  --endpoint-url https://proton.us-east-2.amazonaws.com \
  --region us-east-2 \
  create-service-template \
  --template-name "aws-5-mins-lb-fargate-service" \
  --display-name "aws-5-mins-lb-fargate-service" \
  --description "Fargate Service with an Application Load Balancer"

aws proton-preview \
  --endpoint-url https://proton.us-east-2.amazonaws.com \
  --region us-east-2 \
  create-service-template-major-version \
  --template-name "aws-5-mins-lb-fargate-service" \
  --description "Version 1" \
  --compatible-environment-template-major-version-arns arn:aws:proton:us-east-2:${account_id}:environment-template/aws-5-mins-proton-dev-env:1

tar -zcvf svc-template.tar.gz service/ && aws s3 cp svc-template.tar.gz s3://proton-cli-templates-${account_id}/svc-template.tar.gz && rm svc-template.tar.gz
```

1. After completing the commands from the blog post, go to the [AWS Proton](https://console.aws.amazon.com/proton/) Console to configure an Environment and a Service. 
1. Also, have a look at the [CodePipeline pipeline](https://us-east-2.console.aws.amazon.com/codesuite/codepipeline/pipelines) and [CloudFormation stacks](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks?filteringText=proton&filteringStatus=active&viewNested=true&hideStacks=false&stackId=) that Proton provisions. 

AWS has provided example proton templates at [aws-proton-sample-templates](https://github.com/aws-samples/aws-proton-sample-templates).

There's currently no CloudFormation support but, hopefully, when the service is generally available, it will be included. Once installed, you can run the following command similar to this snippet to create an environment template using Proton.

# Pricing
There is no additional charge for AWS Proton. You pay for AWS resources you create to store and run your application. There are no minimum fees and no upfront commitments. You pay for the resources that are provisioned through Proton such as S3 buckets, EC2 instances, containers, etc. 

# Delete Resources

1. Delete the service you launched based on the `aws-5-mins-lb-fargate-service` service template using this link: [Delete Service](https://us-east-2.console.aws.amazon.com/proton/home?region=us-east-2#/services)
1. Delete the `aws-5-mins-lb-fargate-service` service template: [Delete Service Template](https://us-east-2.console.aws.amazon.com/proton/home?region=us-east-2#/templates/services)
1. Delete the environment you launched based on the `aws-5-mins-proton-dev-env` environment template using this link: [Delete Environment](https://us-east-2.console.aws.amazon.com/proton/home?region=us-east-2#/environments)
1. Delete the `aws-5-mins-proton-dev-env` environment template: [Delete Environment Template](https://us-east-2.console.aws.amazon.com/proton/home?region=us-east-2#/templates/environments)
1. Delete the `aws-5-mins-proton-service-role` IAM Role: [Delete IAM Role](https://console.aws.amazon.com/iam/home?region=us-east-1#/roles)

```
aws proton-preview help
aws proton-preview list-environments --region us-east-2
aws proton-preview list-environment-templates --region us-east-2
aws proton-preview list-services --region us-east-2
aws proton-preview list-service-templates --region us-east-2
aws iam get-role --role-name aws-5-mins-proton-service-role

aws iam delete-role --role-name aws-5-mins-proton-service-role
aws proton-preview delete-account-roles --region us-east-2
```