**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS Config Conformance Packs.

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack
1. Enable the AWS Config Recorder from the [AWS Config Console](https://us-east-2.console.aws.amazon.com/config/home?region=us-east-2#/dashboard).
1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```
sudo rm -rf ~/aws-5-mins
cd ~
git clone https://github.com/PaulDuvall/aws-5-mins.git
cd aws-5-mins/config-conformance-packs
```

1. Run this command to launch a CloudFormation stack that generates Config Conformance Packs and related resources.  


```
aws cloudformation deploy \
--stack-name aws-5-mins-s3-permissions \
--template-file s3-permissions.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-2
```

```
aws cloudformation deploy \
--stack-name aws-5-mins-s3-remediation \
--template-file s3-remediation.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-2
```

* It takes about 4 minutes to launch the [CloudFormation stack](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks) and provision the Config and related resources.
* Go to the [CodePipeline Dashboard](https://us-east-2.console.aws.amazon.com/codepipeline/).


# Deployment Pipeline

# Pricing
TBD

# Delete Resources

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `s3serversideloggingbucket-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

aws cloudformation delete-stack --stack-name aws-5-mins-s3-remediation --region us-east-2
aws cloudformation delete-stack --stack-name aws-5-mins-s3-permissions --region us-east-2

```


# Additional Resources
* [Deploy Conformance Packs across an Organization with Automatic Remediation](https://aws.amazon.com/blogs/mt/deploying-conformance-packs-across-an-organization-with-automatic-remediation/)
* [Operational-Best-Practices-for-Amazon-DynamoDB-with-Remediation.yaml](https://github.com/awslabs/aws-config-rules/blob/master/aws-config-conformance-packs/Operational-Best-Practices-for-Amazon-DynamoDB-with-Remediation.yaml)