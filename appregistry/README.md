**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described [here](https://youtu.be/AZT1OGUnTAw). 

In this episode, we'll be looking at [AWS Service Catalog AppRegistry](https://aws.amazon.com/blogs/mt/increase-application-visibility-governance-using-aws-service-catalog-appregistry/).

AWS Service Catalog released a feature called the AppRegistry. It’s a repository in which you can associate your applications with its related resources. There are many uses for this capability including making it easier to search for resources, classify data, track costs, identify versions, and meet certain compliance certifications. You can use AppRegistry without needing to use Service Catalog. The key benefit you get from AppRegistry is obtaining context between your application and resources. What’s more, you can automate updates of stack and metadata changes by calling AppRegistry from your deployment pipelines when changes occur. 

There are five primary steps to setting up the AppRegistry in an enterprise: 

1. An Administrator configures company-wide shared attribute groups.
1. Each development team sets up attribute groups for their team.
1. Each development team creates applications in the AppRegistry.
1. Each development team associates attribute groups to their applications.
1. Each development team associates existing AWS CloudFormation stacks with their applications.

[Source: Increase application visibility and governance using AWS Service Catalog AppRegistry](https://aws.amazon.com/blogs/mt/increase-application-visibility-governance-using-aws-service-catalog-appregistry/)

# CloudFormation Support

There are four new CloudFormation resources to support the launch of AppRegistry. They are:

* [AWS::ServiceCatalogAppRegistry::AttributeGroup](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalogappregistry-attributegroup.html) – Creates a new attribute group as a container for user-defined attributes. This feature enables users to have full control over their cloud application’s metadata in a rich machine-readable format to facilitate integration with automated workflows and third-party tools.
* [AWS::ServiceCatalogAppRegistry::Application](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalogappregistry-application.html) – Provision a Service Catalog AppRegistry application which is the top-level node in a hierarchy of related cloud resource abstractions.
* [AWS::ServiceCatalogAppRegistry::AttributeGroupAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalogappregistry-attributegroupassociation.html) – Link Applications and Attribute Groups.
* [AWS::ServiceCatalogAppRegistry::ResourceAssociation](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-servicecatalogappregistry-resourceassociation.html) – Link Resources and Resource Types with Applications. 

## Launch CloudFormation Stack

1. From your [AWS CloudShell Environment](https://us-east-1.console.aws.amazon.com/cloudshell/home?region=us-east-1#) in the **us-east-1** region, run the following commands: 

```
sudo rm -rf ~/aws-5-mins
cd ~/
git clone https://github.com/PaulDuvall/aws-5-mins.git
cd aws-5-mins/appregistry
```

1. Run this command to launch a CloudFormation stack that generates an SQS resource.  

```
aws cloudformation create-stack --stack-name aws-5-mins-sqs --template-body file:///home/cloudshell-user/aws-5-mins/appregistry/sqs.yml --capabilities CAPABILITY_IAM --region us-east-1
```

1. Run this command to launch a CloudFormation stack that generates AppRegistry resources.  

```
aws cloudformation create-stack --stack-name aws-5-mins-appregistry --template-body file:///home/cloudshell-user/aws-5-mins/appregistry/appregistry.yml --capabilities CAPABILITY_IAM --region us-east-1
```

View the provisioned [CloudFormation Stacks](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks).

You can run the commands below to see the results of the data that was entered into the AppRegistry when the CloudFormation stacks were launched.

```
sudo chmod +x *.sh
./list-attrib-groups.sh

./list-applications.sh
./list-resources.sh
```

# Pricing
AppRegistry uses the same per API call pricing model that Service Catalog uses. Therefore, after 1,000 API calls in a given month, you’re charged $0.0007 per API call (14 calls for 1 cent). For more information, see [AWS Service Catalog Pricing](https://aws.amazon.com/servicecatalog/pricing/). 

# Delete Resources

Run these command to delete the CloudFormation Stacks and the resources they provisioned in this demo. 

```
aws cloudformation delete-stack --stack-name aws-5-mins-appregistry --region us-east-1

# Wait until above stack is deleted
aws cloudformation delete-stack --stack-name aws-5-mins-sqs --region us-east-1

```

# Additional Resources

* [AWS re:Invent 2020: Gaining application-level governance and cost visibility](https://www.youtube.com/watch?v=9rJ_91AtPJ0
)
* [Increase application visibility and governance using AWS Service Catalog AppRegistry](https://aws.amazon.com/blogs/mt/increase-application-visibility-governance-using-aws-service-catalog-appregistry/)
* [AWS on Air 2020: AWS What’s Next ft. AWS Service Catalog AppRegistry](https://youtu.be/Ez3QdO7UjwU)