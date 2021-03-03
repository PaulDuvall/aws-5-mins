**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at Amazon CodeGuru Security Detectors

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

* [AWS::CodeGuruReviewer::RepositoryAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-codegurureviewer-repositoryassociation.html)
* [Incorporating security in code-reviews using Amazon CodeGuru Reviewer](https://aws.amazon.com/blogs/devops/incorporating-security-in-code-reviews-using-amazon-codeguru-reviewer)
* [Raising code quality for Python applications using Amazon CodeGuru](https://aws.amazon.com/blogs/devops/raising-code-quality-for-python-applications-using-amazon-codeguru/)