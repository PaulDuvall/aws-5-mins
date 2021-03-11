**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at Amazon Macie. Macie uses established rules and machine learning to identify and secure sensitive data. You can configure Macie to continually monitor your S3 buckets so that you can track and secure data as it enters your environment. Using the Macie dashboard, you can view business-sensitive data and set up alerts for incident response.

When Macie discovers, classifies, and protects sensitive data by producing Findings of the analyzes files. It supports over 25 supported [file types](https://docs.aws.amazon.com/macie/latest/user/discovery-supported-formats.html) including zip, .doc(x), .csv, and many other types. 

It analyzes data in these files by searching for data identifiers and using machine learning. There are a number of [managed data identifiers](https://docs.aws.amazon.com/macie/latest/user/managed-data-identifiers.html) provided by Macie - such as AWS secret keys, bank account numbers, and medical identification numbers.

You also have the ability to create [custom data identifiers](https://docs.aws.amazon.com/macie/latest/user/custom-data-identifiers.html) based on your particular requirements. For example, a custom patient id or employee id format.

Macie can be used to help comply with SOC, PCI, FedRAMP, HIPAA, and other compliance regimes.

You can get alerted on findings or query them. Findings can be integrated into [event management systems](https://en.wikipedia.org/wiki/Security_information_and_event_management). 

Macie detects sensitive information that is not encrypted such as unencrypted S3 buckets and the data inside these S3 buckets. 

To produce the [findings](https://docs.aws.amazon.com/macie/latest/user/findings-types.html), you schedule a [data discovery job](https://docs.aws.amazon.com/macie/latest/user/discovery-jobs.html) in Macie to find sensitive data stored in S3 buckets. You can create, store, and monitor data discovery jobs. 

While all the data you classify in Macie is stored in S3, you can temporarily move data not stored in S3 into S3 using services like [Amazon AppFlow](https://aws.amazon.com/appflow/). You can also integrate Macie with [AWS Security Hub](https://aws.amazon.com/security-hub/).

Macie helps classify and identify sensitive data that is not encrypted. You can configure it to send notifications or apply remediations. Macie, enables you to improve your overall security posture.  

# CloudFormation Support
* [AWS::Macie::CustomDataIdentifier](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-macie-customdataidentifier.html) - Create a custom data identifier.
* [AWS::Macie::FindingsFilter](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-macie-findingsfilter.html) - Create a custom filter that groups certain findings.
* [AWS::Macie::Session](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-macie-session.html) - Enable the Macie service and configuration for an AWS Region.

## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2#) in the **us-east-2** region, run the following commands: 

```
git clone https://github.com/aws-samples/amazon-macie-demo-with-sample-data.git
cd amazon-macie-demo-with-sample-data
```

1. Run this command to launch a CloudFormation stack that generates Macie and related resources.  

```
aws cloudformation deploy \
--stack-name aws-5-mins-macie \
--template-file macie.yaml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-2
```

* It takes about 4 minutes to launch the [CloudFormation stack](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks) and provision the Macie resources.
* Go to the [Macie Dashboard](https://us-east-2.console.aws.amazon.com/macie/) and click on [Findings](https://us-east-2.console.aws.amazon.com/macie/home?region=us-east-2#findings).

# Pricing
Macie charges you $0.10 per S3 bucket that it analyzes per month. For the data processed for sensitive data discovery and after the first 1 GB per month, Macie charges $1.00 per GB for the next 50,000 GB/month, $0.50 per GB for the next 450,000 GB/month, and $0.25 per GB when it's over 500,000 GB/month. For more information, see [Amazon Macie Pricing](https://aws.amazon.com/macie/pricing/).

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-macie --region us-east-2
```

# Additional Resources