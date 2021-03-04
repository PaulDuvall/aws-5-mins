**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS CloudFormation. If you have viewed some of the other videos, you have seen and/or launched CloudFormation stacks from templates.

With a CloudFormation template, you can define your infrastructure as code. 

* These are the [top-level objects](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html) of a CloudFormation template: Format Version, Description, Metadata, Parameters, Rules, Mappings, Conditions, Transform, Resources, Outputs. The **Resources** object is the only object that is *required*.

There are also:
* **[Pseudo Parameters](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/pseudo-parameter-reference.html)** - parameters that are predefined by CloudFormation so that you do not declare them in your template.
* **[Intrinsic Functions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html)** - built-in functions that assign values to properties that are not available until runtime.

## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-1.console.aws.amazon.com/cloudshell/home?region=us-east-1#) in the **us-east-1** region, run the following commands: 

```
sudo rm -rf ~/aws-5-mins
cd ~/
git clone https://github.com/PaulDuvall/aws-5-mins.git
cd aws-5-mins/cloudformation
```

1. Run this command to launch a CloudFormation stack that provisons an EC2 instance.  

```
aws cloudformation deploy \
--stack-name aws-5-mins-cfn \
--template-file cfn.yml \
--parameter-overrides Environment=Prod \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--region us-east-1
```

# Pricing
There is no additional cost for using CloudFormation. You are only charged for the use of the resources that the stacks provision. 

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-cfn
```

# Additional Resources