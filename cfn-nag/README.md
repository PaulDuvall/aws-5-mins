**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at Stelligent's [cfn_nag](https://github.com/stelligent/cfn_nag) open source framework. cfn_nag is a static analysis tool for finding security vulnerabilities in CloudFormation templates.

With cfn_nag, you can perform static code analysis of AWS CloudFormation templates to prevent undesirable resource specifications, perform proactive preventative controls such as preventng AWS resource provisioning. You can also integrate cfn_nag into a deployment pipeline.

Here are some examples of the types of checks cfn_nag can perform:
* Identify EC2 Instance Security Groups with wide-open ingress of `0.0.0.0/0`
* Identify IAM Permissions that employ wildcards to all `(*)` resources or all `(*)` actions
* Verify that EBS volumes are encrypted
* Verify that access logging is enabled

cfn_nag includes rules that apply universally across environments and enterprises. It also supports the development of custom rules to allow organization-specific rules for compliance and security controls.

One of the key benefits of cfn_nag is that you can learn about security vulnerabilities prior to provisioning AWS resources which can help reduce costs and risk.

## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```
sudo rm -rf ~/aws-5-mins-cfn-nag
mkdir ~/aws-5-mins-cfn-nag
aws s3 mb s3://aws-5-mins-cfn-nag-$(aws sts get-caller-identity --output text --query 'Account')
cd ~/aws-5-mins-cfn-nag

cd ~/aws-5-mins-cfn-nag
git clone https://github.com/PaulDuvall/aws-compliance-workshop.git
cd ~/aws-5-mins-cfn-nag/aws-compliance-workshop/lesson2-preventive
zip aws-5-mins-cfn-nag-examples.zip *.*
aws s3 sync ~/aws-5-mins-cfn-nag/aws-compliance-workshop/lesson2-preventive s3://aws-5-mins-cfn-nag-$(aws sts get-caller-identity --output text --query 'Account')

aws cloudformation deploy \
--stack-name aws-5-mins-cfn-nag-pipeline \
--template-file ccoa-2-cfn-nag-pipeline.yml \
--capabilities CAPABILITY_NAMED_IAM \
--parameter-overrides CodeCommitS3Bucket=aws-5-mins-cfn-nag-$(aws sts get-caller-identity --output text --query 'Account') CodeCommitS3Key=aws-5-mins-cfn-nag-examples.zip \
--no-fail-on-empty-changeset \
--region us-east-2
```

* It takes about 1 minute to launch the [CloudFormation stack](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks) and provision the CodePipeline resources.
* Go to the [CodePipeline Dashboard](https://us-east-2.console.aws.amazon.com/codepipeline/).

# Delete Resources

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `aws-5-mins-cfn-nag-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

aws cloudformation delete-stack --stack-name aws-5-mins-cfn-nag-pipeline --region us-east-2
```

# Additional Resources