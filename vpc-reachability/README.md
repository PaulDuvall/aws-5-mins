**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at [Amazon VPC Reachability Analyzer](https://docs.aws.amazon.com/vpc/latest/reachability/what-is-reachability-analyzer.html).

With Amazon VPC, you can create a logically isolated private network in the AWS cloud. VPC Reachability Analyzer is a network diagnostics tool that troubleshoots reachability between two endpoints in a VPC. With VPC Reachability Analyzer, you can ensure that your network configuration is as intended.

There are many different resources that can communicate inside and outside your VPC including AWS Lambda, Amazon S3, VPC Endpoints, VPC Gateway, VPC Peering, and AWS Transit Gateway - just to name a few.

With all of these ways to communicate between resources, the potential for misconfiguration increases. VPC Reachability Analyzer uses automate reasoning to analyzer all possible paths between a source and destination and informs you whether it's those endpoints are reachable or not.

You can specify any of the following endpoint types: VPN Gateways, Instances, Network Interfaces, Internet Gateways, VPC Endpoints, VPC Peering Connections, and Transit Gateways for your source and destination of communication. [Source](https://aws.amazon.com/blogs/aws/new-vpc-insights-analyzes-reachability-and-visibility-in-vpcs/)

# Pricing
Price per analysis processed by VPC Reachability Analyzer: $0.10. See [VPC Pricing](https://aws.amazon.com/vpc/pricing/) for more information.

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

1. Run this command to launch a CloudFormation stack that generates VPC and released resources.  

```
aws cloudformation deploy \
--stack-name aws-5-mins-vpc \
--template-file vpc.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-1
```

Once the [CloudFormation stack](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/) is `CREATE_COMPLETE`, go to the [EC2 Console](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Instances:sort=instanceState) and select the `InstanceA`, `InstanceB`, and `InstanceC` instances. For each instances, select **Security**, then **Inbound rules** and **Outbound rules**.

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
    
aws ec2 create-tags --resources NETWORK-PATH-ID-AB --tags Key=Name,Value=A2B-Reachable

```

After running the commands above, go to [VPC Reachability Analyzer](https://console.aws.amazon.com/vpc/home?region=us-east-1#ReachabilityAnalyzer:). You will see the analysis result as **Reachable**. If you click the URL link of analysis id starting with **nip**, you can see the route hop by hop.

```
# Assess Path between Instance A and Instance C. Get the values from VPC CloudFormation stack outputs.
aws ec2 create-network-insights-path \
    --source VALUE-OF-INSTANCE-A \
    --destination VALUE-OF-INSTANCE-C \
    --destination-port 22 \
    --protocol TCP 


aws ec2 create-tags --resources NETWORK-PATH-ID-AC --tags Key=Name,Value=A2C-NotReachable

# Analyze whether Instance A can reach Instance C
aws ec2 start-network-insights-analysis \
    --network-insights-path-id NETWORK-PATH-ID-AC
    
```

After running the commands above, go to [VPC Reachability Analyzer](https://console.aws.amazon.com/vpc/home?region=us-east-1#ReachabilityAnalyzer:). It'll take about 30 seconds to analyze the VPC configuration and the paths between instance A and instance C. Once complete, it will show that this path is not reachable because the security group attached to instance C does not allow any incoming traffic.


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