# Security Hub Remediation

## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```

aws cloudformation create-stack \
--stack-name aws-5-mins-security-hub-remediation-pipeline \
--template-url "https://solutions-reference.s3.amazonaws.com/aws-security-hub-automated-response-and-remediation/latest/aws-sharr-deploy.template" \
--capabilities CAPABILITY_NAMED_IAM \
--region us-east-2
```

* It takes about 1 minute to launch the [CloudFormation stack](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks) and provision the CodePipeline resources.

# Delete Resources

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```
aws s3api list-buckets --query 'Buckets[?starts_with(Name, `aws-5-mins-security-hub-remediation-`) == `true`].[Name]' --output text | xargs -I {} aws s3 rb s3://{} --force

aws cloudformation delete-stack --stack-name aws-5-mins-security-hub-remediation-pipeline --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-security-hub-remediation-pipeline --region us-east-2

```