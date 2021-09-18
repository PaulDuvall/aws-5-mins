# Deployment pipeline for encryption prevention, detection and remediation workflow

Review and ensure that you have setup your [development environment](0.2) before going through the steps below.

In this sublesson, you will walk through an exercise to deploy a full-stack and *fully-automated* Continuous Encryption solution on AWS using Amazon CloudWatch Event Rules, AWS Config and Config Rules, IAM, AWS CodePipeline, AWS CodeBuild, AWS Lambda, Amazon SNS, Amazon S3, cfn_nag, and other tools and services.

# Disable AWS Config


Replace `ceoa-***`, `CONFIGRECORDERNAME`, and `DELIVERYCHANNELNAME` with the actual name of the resources.

```
aws configservice delete-config-rule --config-rule-name s3-bucket-server-side-encryption-enabled
aws configservice describe-configuration-recorders
aws configservice delete-configuration-recorder --configuration-recorder-name default
aws configservice describe-delivery-channels
aws configservice delete-delivery-channel --delivery-channel-name default
```
 
# Deployment Steps

There are four main steps in launching this solution: preparing an AWS account, create and store source files, launching the CloudFormation stack, and testing the deployment. Each is described in more detail in this section. Please note that you are responsible for any fees incurred while creating and launching your solution.

## Step 1. Prepare an AWS Account

Here are the prerequisites and assumptions for this solution:

* **AWS Account** – Follow these instructions to create an AWS Account: Creating an AWS Account. Be sure you have signed up for the CloudFormation service and have the proper permissions.
* **AWS CloudTrail** – A CloudTrail log should already be enabled for the region in which you are running this example. See [Creating a Trail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-create-a-trail-using-the-console-first-time.html) for more information.
* **AWS Region** – Use the region selector in the navigation bar of the console to choose your preferred AWS region.
* **AWS Cloud9** – All of the CLI examples assume that you are using the AWS Cloud9 IDE. To learn how to install and configure Cloud9, go to [Automating AWS Cloud9](https://stelligent.com/2018/04/09/automating-aws-cloud9/). You can easily adapt the commands to perform the same actions in a different IDE, but the instructions are outside the scope of this sublesson.
* **AWS Config** – This solution assumes you have **not** enabled AWS Config. If you have, you will receive an error when launching the CloudFormation stack as it provisions a Config Recorder and Delivery Channel.

## Step 2. Create and Store Source Files

In this section, you will create six source files that will be stored in S3 and then uploaded to AWS CodeCommit when launching the CloudFormation stack. The names are listed below.

From your AWS Cloud9 terminal, type the following to setup your directory structure:

```
cd ~/environment/ceoa
aws s3 mb s3://ce-$(aws sts get-caller-identity --output text --query 'Account')
mkdir ce-codecommit-files
cd ~/environment/ceoa/ce-codecommit-files
```

Create empty source files:

```
touch buildspec.yml
touch buildspec-lambda.yml
touch ce-pipeline.yml
touch index.js
touch package.json
touch README.md
touch sam-s3-remediation.yml
touch volume.yml

```
Save the files.

### buildspec-lambda.yml

Copy the contents from **[buildspec-lambda.yml](https://raw.githubusercontent.com/PaulDuvall/aws-encryption-workshop/master/lesson8-continuous/buildspec-lambda.yml)** to your local **buildspec-lambda.yml** file in Cloud9 and save it. 

AWS CodeBuild will use this buildspec to build the Lambda function that runs the automatic encryption remediation to fix the non-encrypted S3 Bucket.

CodeBuild runs an [aws cloudformation](https://docs.aws.amazon.com/cli/latest/reference/cloudformation/index.html) CLI command to package a SAM template and then exports the contents as a zip file into S3 so that Lambda can run the code.

### ce-pipeline.yml

Copy the source contents from the [ce-pipeline.yml](https://raw.githubusercontent.com/PaulDuvall/aws-encryption-workshop/master/lesson8-continuous/ce-pipeline.yml) file and save it to your local file in your Cloud9 environment called **ce-pipeline.yml**. The file is a 500-line CloudFormation template.

This CloudFormation template defines a [AWS::CodeCommit::Repository](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-codecommit-repository.html) resource, which creates a new CodeCommit repository to store the source files that run the remediation.

The **CodeCommitS3Bucket** parameter refers to the name of the S3 bucket that you will create to store the source files. The **CodeCommitS3Key** parameter is the S3 key/folder that refers to the name of the zip file you will be creating.

The CloudFormation template also provisions an AWS Config Rule using the [AWS::Config::ConfigRule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-config-configrule.html) resource. The purpose of this resource definition is to provision the **S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED** managed config rule, which detects when S3 buckets allow the ability to write to them. This resource definition ensures that the Config **DeliveryChannel** and **ConfigRecorder** resources have already been provisioned.

The template also defines a CodeBuild project using the [AWS::CodeBuild::Project](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-codebuild-project.html) resource. It refers to the name of the CodeCommit repository and the name of the [buildspec](https://docs.aws.amazon.com/codebuild/latest/userguide/build-spec-ref.html) file in the CodeCommit repo (**buildspec-lambda.yml**). The purpose of this resource definition is to provision CodeBuild so that it can run commands in its container to build a Lambda function that automatically remediates a noncompliant resource (in this case, an S3 Bucket).

The template also defines a deployment pipeline using the [AWS::CodePipeline::Pipeline](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-codepipeline-pipeline.html) resource. The purpose of this resource definition is to provision all of the stages and actions for the CodePipeline workflow which, in turn, gets its source files from CodeCommit, and builds and deploys the code run by Lambda.

This CloudFormation template defines *CloudFormation* as a CodePipeline *deploy* provider.

* The name of the CodePipeline stage is **Deploy** (it can be any valid CodePipeline name).
* It takes in **lambdatrigger-BuildArtifact** as its input artifact (which is the OutputArtifacts of the Build stage).
* It uses CloudFormation as its Deploy provider to deploy the Lambda function to AWS.
* **CHANGE_SET_REPLACE** creates the CloudFormation change set if it does not exist based on the stack name and template that you declare. If the change set exists, AWS CloudFormation deletes it, and then creates a new one.
* TemplatePath refers to the generated file (**template-export.json**) from the SAM template that was stored in the OutputArtifacts. (**lambdatrigger-BuildArtifact**) generated in the Build stage of this pipeline. The full reference is **lambdatrigger-BuildArtifact::template-export.json**.
* **CHANGE_SET_EXECUTE** executes a CloudFormation change set.

Finally, the template two *Outputs* in this template: **PipelineUrl** and **LambdaTrustRole**. **LambdaTrustRole** is used by the SAM template definition so that we can define the IAM role in one location and refer to its output as an input when defining the Lambda function in the SAM template. Therefore, the name you use as the Output in this template must be used in the SAM template when defining the role.

### index.js

Copy the contents from **[index.js](https://raw.githubusercontent.com/PaulDuvall/aws-encryption-workshop/master/lesson8-continuous/index.js)** to your local **index.js** file in Cloud9 and save it. 

This is the Node.js function that Lambda runs to remove the S3 bucket policy for S3 buckets that allow writes to their buckets.


### package.json

Copy the contents from **[package.json](https://raw.githubusercontent.com/PaulDuvall/aws-encryption-workshop/master/lesson8-continuous/package.json)** to your local **package.json** file in Cloud9 and save it. 

This is a metadata file that all Node.js apps need to operate.

### README.md

Copy the contents below into the README.md file and save the file.

`# s3-bucket-server-side-encryption-enable-app`

### sam-s3-remediation.yml

Copy the contents from **[sam-s3-remediation.yml](https://raw.githubusercontent.com/PaulDuvall/aws-encryption-workshop/master/lesson8-continuous/sam-s3-remediation.yml)** to your local **sam-s3-remediation.yml** file in Cloud9 and save it.

This file is an [AWS Serverless Application Model](https://aws.amazon.com/serverless/sam/) (SAM) template that provisions a Lambda function by defining the name of its handler (which is associated with the name of its file: **index.js**), the runtime environment and version (Node.js 10.x), and a CloudWatch Event Rule with the pattern that needs to match in order to trigger the event which runs the Lambda function as its target. For more information, see [Event Patterns in CloudWatch Events](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/CloudWatchEventsandEventPatterns.html). The purpose of the CloudWatch Event Rule is to detect noncompliant S3 buckets and then automatically run a Lambda function that remediates these noncompliant buckets.

The SAM uses the CloudFormation Transform to specify CloudFormation macros to convert its serverless domain-specific language (DSL) into CloudFormation. You can mix the SAM DSL with CloudFormation resource definitions in the same file.

Here are the key SAM components in this solution:

**AWS Lambda** – There are two resources defined in the SAM template. The first is the AWS::Lambda::Permission and the second is AWS::Serverless::Function. [AWS::Serverless::Function](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-template.html#serverless-sam-template-function) also defines a CloudWatch Event which triggers the Lambda function that is defined as part of its resource definition. "Under the hood", this calls [AWS::Events::Rule](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-events-rule.html) to define a CloudWatch Events Rule.

### buildspec.yml

Copy the source contents from the [buildspec.yml](https://raw.githubusercontent.com/PaulDuvall/aws-encryption-workshop/master/lesson8-continuous/buildspec.yml) file and save it to your local file in your Cloud9 environment called **buildspec.yml**.

### volume.yml

Copy the source contents from the [volume.yml](https://raw.githubusercontent.com/PaulDuvall/aws-encryption-workshop/master/lesson8-continuous/volume.yml) file and save it to your local file in your Cloud9 environment called **volume.yml**.

### Sync the files with your S3 bucket

In this section, you will zip and upload all of the source files to S3 so that they can be committed to the CodeCommit repository that is automatically provisioned by the stack generated by the **ce-pipeline.yml** template.

From your AWS Cloud9 environment, type the following:

```
mkdir ~/environment/ceoa/ce-codecommit-files
cd ~/environment/ceoa/ce-codecommit-files
zip ce-examples.zip *.*
aws s3 sync ~/environment/ceoa/ce-codecommit-files s3://ce-$(aws sts get-caller-identity --output text --query 'Account')
```

## Step 3. Launch the Stack

From your AWS Cloud9 environment, type the following:

```
aws cloudformation create-stack --stack-name ce-ar --template-body file:///home/ec2-user/environment/ceoa/ce-codecommit-files/ce-pipeline.yml --parameters ParameterKey=EmailAddress,ParameterValue=fake-email@fake-fake-fake-email.com ParameterKey=CodeCommitS3Bucket,ParameterValue=ce-$(aws sts get-caller-identity --output text --query 'Account') ParameterKey=CodeCommitS3Key,ParameterValue=ce-examples.zip ParameterKey=S3ComplianceResourceId,ParameterValue=ce-s3-unencrypted-$(aws sts get-caller-identity --output text --query 'Account') --capabilities CAPABILITY_NAMED_IAM --disable-rollback
```

## Step 4. Test the Deployment

First, verify that the [CloudFormation](https://console.aws.amazon.com/cloudformation/) stack you just launched (called **ce-ar**) was successfully created. Click on the **PipelineUrl** Output to launch deployment pipeline in CodePipeline to see it running. Verify that the pipeline successfully went through all stages (as shown below).

Next, you will create an unencrypted S3 bucket that allows people to store files to the bucket. Here are the steps:

1. Go to your Cloud9 IDE terminal and type the following:
```aws s3 mb s3://ce-s3-unencrypted-$(aws sts get-caller-identity --output text --query 'Account')```
1. Go to the [S3](https://console.aws.amazon.com/s3/) console and select the `ce-s3-unencrypted-ACCOUNTID` bucket and choose the *Properties* pane.
1. Verify that the **Default encryption** is *Disabled*.

### Verify Compliance
In this section, you will verify that the Config Rule has been triggered and that the S3 bucket resource has been automatically remediated.
1. Go to the [Config](https://console.aws.amazon.com/config/) console.
2. Click on **Rules**.
3. Select the **s3-bucket-server-side-encryption-enabled** rule.
4. Click the **Re-evaluate** button.
5. Go back to **Rules** in the [Config](https://console.aws.amazon.com/config/) console.
6. Go to the [S3](https://console.aws.amazon.com/s3/) console and choose the `ce-s3-unencrypted-ACCOUNTID` bucket
7. Verify that the **Default encryption** is *Enabled*.
8. Go back to **Rules** in the [Config](https://console.aws.amazon.com/config/) console and confirm that the **s3-bucket-server-side-encryption-enabled** rule is **Compliant**. 

# Summary

In this sublesson, you learned how to setup a robust automated encryption and remediation infrastructure for noncompliant AWS resources using services such as S3, AWS Config & Config Rules, Amazon CloudWatch Event Rules, AWS Lambda, IAM, and others. You did this by automating all of the provisioning by using tools like AWS CloudFormation, AWS CodePipeline, AWS CodeCommit, and AWS CodeBuild.

By leveraging this approach, your AWS infrastructure is capable of rapidly scaling resources while ensuring these resources are always in compliance with encryption requirements without humans needing to manually intervene.

Consider the possibilities when adding hundreds if not thousands of rules and remediations to your AWS infrastructure. Below is just an example of some of the different types of Managed Config Rules you can run. What if you took each of these and developed custom remediations for them and ensured they were running across all of your AWS accounts? Or, what if you wrote your own Config Rules and triggered CloudWatch Events to execute remediations you developed in Lambda? This way your compliance remains in lockstep with the rest of your AWS infrastructure.

As a result, engineers can focus their efforts on automating the prevention, detection, and remediation of their AWS infrastructure rather than manually hunting down every noncompliant resource, creating a ticket, and manually fixing the issue. This is Continuous Encryption – at scale!