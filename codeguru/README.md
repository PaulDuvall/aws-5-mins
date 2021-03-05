**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at Amazon CodeGuru Security Detectors

TBD


# CloudFormation Support
TBD


## Launch CloudFormation Stack

Run the following steps to launch resources that launch the CloudFormation stack.

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 
```
sudo rm -rf ~/aws-5-mins
cd ~/
git clone https://github.com/PaulDuvall/aws-5-mins.git
cd aws-5-mins/codeguru
```

1. Run this command to launch a CloudFormation stack that creates a CodeCommit repo and associates it to Amazon CodeGuru.

```
aws cloudformation deploy \
--stack-name aws-5-mins-codeguru \
--template-file codeguru-security.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-2
```

```
git clone https://github.com/stelligent/banana-service
cd banana-service
curl -s "https://get.sdkman.io" | bash
sdk install springboot
sdk install gradle 6.8.3
spring init --build=gradle --package-name=com.stelligent --dependencies=web,actuator,hateoas -n Banana banana-service
gradle bootRun
cd banana-service/build
jar cf banana.jar classes
aws s3 sync ~/banana-service/banana-service s3://aws-5-mins-codeguru-$(aws sts get-caller-identity --output text --query 'Account') --region us-east-2
```

* View the status by going to the [AWS CloudFormation](https://console.aws.amazon.com/cloudformation/home?region=us-east-2#) console. Once the status is **CREATE_COMPLETE**, view the [CodeGuru](https://us-east-2.console.aws.amazon.com/codeguru/reviewer/?region=us-east-2#/associations).
* Choose the [Create repository analysis](https://us-east-2.console.aws.amazon.com/codeguru/reviewer/?region=us-east-2#/codereviews/create) button and choose the **Code and security recommendations (Java)** radio button. 
* Click the **Create repository analysis** button.


# Pricing
TBD

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME
```

# Additional Resources

* [AWS::CodeGuruReviewer::RepositoryAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-codegurureviewer-repositoryassociation.html)
* [https://github.com/aws-samples/aws-codeguru-profiler-python-demo-application](https://github.com/aws-samples/aws-codeguru-profiler-python-demo-application)
* [Incorporating security in code-reviews using Amazon CodeGuru Reviewer](https://aws.amazon.com/blogs/devops/incorporating-security-in-code-reviews-using-amazon-codeguru-reviewer)
* [Raising code quality for Python applications using Amazon CodeGuru](https://aws.amazon.com/blogs/devops/raising-code-quality-for-python-applications-using-amazon-codeguru/)
* [10 Java security best practices](https://snyk.io/blog/10-java-security-best-practices/)
* [s3-bucket-loader example](https://github.com/PaulDuvall/s3-bucket-loader)


```
git clone https://github.com/aws-samples/building-java-apps-using-code-pipeline.git codeGuruDemoApp

aws codeguru-reviewer associate-repository --repository CodeCommit={Name=CdkStackJavaApp-repo} 
aws codeguru-reviewer list-repository-associations 

aws codeguru-reviewer create-code-review --name mycodereview$TAG --repository-association-arn <ARN> --type RepositoryAnalysis={RepositoryHead={BranchName=master}}
```
