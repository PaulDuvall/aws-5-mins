**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at [Amazon VPC Reachability Analyzer](https://aws.amazon.com/blogs/aws/new-vpc-insights-analyzes-reachability-and-visibility-in-vpcs/).

@todo: How it Works



# CloudFormation Support

* [AWS::EC2::NetworkInsightsPath](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightspath.html)
* [AWS::EC2::NetworkInsightsAnalysis](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightsanalysis.html)

## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-1.console.aws.amazon.com/cloudshell/home?region=us-east-1#) in the **us-east-1** region, run the following commands: 

```
sudo rm -rf ~/aws-5-mins
cd ~/
git clone https://github.com/PaulDuvall/aws-5-mins.git
cd aws-5-mins/vpc-reachability
```

1. Run this command to launch a CloudFormation stack that generates a VPC resource.  

```
aws cloudformation deploy \
--stack-name aws-5-mins-vpc \
--template-file vpc.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-1
```

## CLI

```
# Assess Path between Instance A and Instance B. Get the values from VPC CloudFormation stack outputs.
aws ec2 create-network-insights-path \
    --source VALUE-OF-INSTANCE-A \
    --destination VALUE-OF-INSTANCE-B \
    --destination-port 22 \
    --protocol TCP 

# Analyze whether Instance A can reach Instance B?
aws ec2 start-network-insights-analysis \
    --network-insights-path-id NETWORK-PATH-ID-AB
    
# You can now see the analysis result as Reachable. If you click the URL link of analysis id nip-xxxxxxxxxxxxxxxxx, you can see the route hop by hop.    
aws ec2 create-tags --resources NETWORK-PATH-ID-AB --tags Key=Name,Value=,Value=A2B-Reachable

# The communication from instance A to instance C is not reachable because the security group attached to instance C does not allow any incoming traffic.
aws ec2 create-tags --resources NETWORK-PATH-ID-AC --tags Key=Name,Value=A2C-NotReachable

# Assess Path between Instance A and Instance C
aws ec2 create-network-insights-path \
    --source VALUE-OF-INSTANCE-A \
    --destination VALUE-OF-INSTANCE-C \
    --destination-port 22 \
    --protocol TCP 

# Analyze whether Instance A can reach Instance C?
aws ec2 start-network-insights-analysis \
    --network-insights-path-id NETWORK-PATH-ID-AC
```

# Pricing
@todo

# Delete Resources

```
aws ec2 delete-network-insights-analysis \
    --network-insights-analysis-id NETWORK-INSIGHTS-ANALYSIS-ID

aws ec2 delete-network-insights-analysis \
    --network-insights-analysis-id NETWORK-INSIGHTS-ANALYSIS-ID

aws ec2 delete-network-insights-path \
    --network-insights-path-id NETWORK-INSIGHTS-PATH-ID
    
aws ec2 delete-network-insights-path \
    --network-insights-path-id NETWORK-INSIGHTS-PATH-ID
    
aws cloudformation delete-stack --stack-name aws-5-mins-vpc
```

# Additional Resources

* [New – VPC Reachability Analyzer](https://aws.amazon.com/blogs/aws/new-vpc-insights-analyzes-reachability-and-visibility-in-vpcs/)
* [What is VPC Reachability Analyzer?](https://docs.aws.amazon.com/vpc/latest/reachability/what-is-reachability-analyzer.html)
* [Getting started with VPC Reachability Analyzer using the AWS CLI](https://docs.aws.amazon.com/vpc/latest/reachability/getting-started-cli.html)
* [AWS::EC2::NetworkInsightsPath](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightspath.html)
* [AWS::EC2::NetworkInsightsAnalysis](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-networkinsightsanalysis.html)
* [AWS re:Invent 2019: Provable access control: Know who can access your AWS resources (SEC343-R)](https://www.youtube.com/watch?v=6DX7p-OirGU)