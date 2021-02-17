You can find the [5-minute video](https://youtu.be/mSMlxUJERdg) that walks through all of the steps described here. 

In this episode, we'll be looking at AWS Audit Manager. 

![How it Works](https://github.com/PaulDuvall/aws-5-mins/blob/main/_img/audit-manager-howitworks.png)

With [AWS Audit Manager](https://aws.amazon.com/audit-manager/), you can continuously audit your AWS usage to simplify how you assess risk and compliance. It's a fully-managed service that continuously collects data to help prepare for audits and integrates with over 155 AWS services to provide a single pane of glass on audit-related activities. Audit Manager uses established frameworks for PCI, HIPAA, and others. Essentially, it help you maintains an always audit ready state – whether it's an internal or external audit. It is generally available.

First, you select a prebuilt framework or custom framework - there are currently 29 industry frameworks (e.g., CIS, AWS, PCI, etc.) from which to choose. Then, you define the assessment scope by selecting the AWS service(s) you want to audit, and activate it. What's more, you can generate assessments reports to provide to auditors. It takes about 24 hours to generate a list of compliance checks along with evidence folders indicating why that particular check failed.

Audit Manager integrates with [AWS Security Hub](https://aws.amazon.com/about-aws/whats-new/2020/12/aws-security-hub-integrates-with-aws-audit-manager-for-simplified-security-posture-management/), AWS Config, AWS Control Tower, and AWS CloudTrail.

# CloudFormation Support
[AWS::AuditManager::Assessment](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-auditmanager-assessment.html) provides the ability to automate the provisioning of an assessment in Audit Manager. 

## Launch CloudFormation Stack

1. Launch a Cloud9 Environment in **us-east-1** using these [instructions](https://github.com/PaulDuvall/aws-5-mins/tree/main/cloud9).
1. Create an empty YAML file.

```
mkdir my-aws-5-mins
cd my-aws-5-mins
touch audit-manager.yml
```

1. Copy the contents from **[audit-manager.yml](https://raw.githubusercontent.com/PaulDuvall/aws-5-mins/main/audit-manager/audit-manager.yml)** to your local **audit-manager.yml** file in Cloud9 and save it. 
1. Run this command to launch a CloudFormation stack that generates an Audit Manager assessment. 

```
aws cloudformation deploy \
--stack-name aws-5-mins-auditmanager \
--template-file audit-manager.yml \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-1
```

It takes less than 1 minute to launch the [CloudFormation stack](https://console.aws.amazon.com/cloudformation/) and the Audit Manager assessment begins. You will need to wait up to 24 hours to view collected evidence. You can visit the [Audit Manager](https://console.aws.amazon.com/auditmanager/home) Console to see the assessment configuration.

Here, you see summary of evidence folders for a particular control.

![Control Evidence](https://github.com/PaulDuvall/aws-5-mins/blob/main/_img/audit-manager-control-evidence.png)

The next diagram provides the control evidence detail.

![Control Evidence Detail](https://github.com/PaulDuvall/aws-5-mins/blob/main/_img/audit-manager-control-detail.png)

Here's an overview of an [Audit Manager Assessment](https://docs.aws.amazon.com/audit-manager/latest/userguide/review-assessments.html).

# Deployment Pipeline
AWS Audit Manager is a regional service. You might deploy it on a per region basis or as part of an overall AWS account or AWS Organizations bootstrapping setup. For example, you might use AWS CodePipeline to use CloudFormationStackSet and CloudFormationStackInstance actions to deploy a CloudFormation StackSet across multiple regions and multiple AWS accounts. 

# Pricing
A resource assessment collects, stores, and manages evidence in the form a resource snapshot configuration, user activity, or a compliance check result. AWS Audit Manager currently charges $1.25 per 1,000 resource assessments per account per region. For more information, see [AWS Audit Manager Pricing](https://aws.amazon.com/audit-manager/pricing/).

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-auditmanager
```