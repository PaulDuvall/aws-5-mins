**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS CloudFormation. If you have viewed some of the other videos, you have seen and/or launched CloudFormation stacks from templates.

With a CloudFormation template, you can define your infrastructure as code. 

* There are [six top-level objects](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-anatomy.html) of a CloudFormation template: **AWSTemplateFormatVersion**, **Description**, **Parameters**, **Resources**, **Mappings**, and **Outputs**. The **Resources** object is the only object that is *required*.
* **Resources** - contain the definitions of the AWS resources you want to create with the template. Each resource is listed separately and specifies the properties necessary for creating that particular resource. The resource declaration begins with a String that specifies the logical name for the resource. The logical name can be used to refer to the resources within the template.
* **Parameters** - declare values that can be passed to the template when you create the Stack. A parameter is an effective way to specify anything you want users to customize or store in the template itself.
* **Mappings** - declare conditional values that are evaluated in a similar manner as a switch statement. An example mapping might be to select the correct AMI for the Region and the Architecture Type for the instance type.
* **Outputs** - define custom values that are returned by the describe-stacks command and in the AWS Management Console Outputs tab after the stack is created. You can use Output values to return information from the resources in the stacks such as the URL for a website created in the template.
* **[Pseudo Parameters](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/pseudo-parameter-reference.html)** - parameters that are predefined by CloudFormation so that you do not declare them in your template.
* **[Intrinsic Functions](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html)** - built-in functions that assign values to properties that are not available until runtime.

# CloudFormation Template
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

# Pricing
There is no additional cost for using CloudFormation. You are only charged for the use of the resources that the stacks provision. 

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME
```

# Additional Resources