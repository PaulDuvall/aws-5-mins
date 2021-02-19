**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at [Amazon VPC Reachability Analyzer](https://aws.amazon.com/blogs/aws/new-vpc-insights-analyzes-reachability-and-visibility-in-vpcs/).

@todo: How it Works

# CloudFormation Support

## Launch CloudFormation Stack

1. Launch a Cloud9 Environment in **us-east-1** using these [instructions](https://github.com/PaulDuvall/aws-5-mins/tree/main/cloud9).
1. Create an empty YAML file.

```
mkdir ~/environment/my-aws-5-mins
cd ~/environment/my-aws-5-mins
touch audit-manager.yml
```

1. Copy the contents from **[audit-manager.yml](https://raw.githubusercontent.com/PaulDuvall/aws-5-mins/main/audit-manager/audit-manager.yml)** to your local **audit-manager.yml** file in Cloud9 and save it. 
1. Run this command to launch a CloudFormation stack that generates an Audit Manager assessment. 

```
aws cloudformation create-stack --stack-name aws-5-mins-auditmanager --template-body file://audit-manager.yml --capabilities CAPABILITY_IAM --region us-east-1
```

# Deployment Pipeline
TBD

# Pricing
@todo

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-vpc-reachability
```


# Additional Resources

* [New – VPC Reachability Analyzer](https://aws.amazon.com/blogs/aws/new-vpc-insights-analyzes-reachability-and-visibility-in-vpcs/)
* [What is VPC Reachability Analyzer?](https://docs.aws.amazon.com/vpc/latest/reachability/what-is-reachability-analyzer.html)
* [AWS::EC2::NetworkInsightsPath](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightspath.html)
* [AWS::EC2::NetworkInsightsAnalysis](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightsanalysis.html)
* [AWS re:Invent 2019: Provable access control: Know who can access your AWS resources (SEC343-R)](https://www.youtube.com/watch?v=6DX7p-OirGU)