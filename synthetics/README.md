**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at Amazon CloudWatch Synthetics.

TBD


# CloudFormation Support
* [AWS::Synthetics::Canary](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-synthetics-canary.html)

## Launch CloudFormation Stack

TBD

```
aws cloudformation deploy \
--stack-name aws-5-mins-SERVICENAME \
--template-file service-name.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-1
```


# Deployment Pipeline

# Pricing
TBD

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME
```

# Additional Resources

* [AWS::Synthetics::Canary](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-synthetics-canary.html)
* [Using synthetic monitoring](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries.html)