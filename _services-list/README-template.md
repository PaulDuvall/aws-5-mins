**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at TBD

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

TBD

```
aws cloudformation deploy \
--stack-name aws-5-mins-SERVICENAME \
--template-file service-name.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-2
```


# Deployment Pipeline

# Pricing
TBD

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME --region us-east-2
aws cloudformation wait stack-delete-complete --stack-name aws-5-mins-SERVICENAME --region us-east-2
```

# Additional Resources