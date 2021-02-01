**NOTE: This video has not been released yet.**

You can find the [5-minute video](https://youtu.be/mSMlxUJERdg) that walks through all of the steps described here. 

In this episode, we'll be looking at [Amazon AppSync](https://aws.amazon.com/appsync/). 

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

1. Copy the contents from **[audit-manager.yml](https://raw.githubusercontent.com/PaulDuvall/aws-5-mins/main/audit-manager/audit-manager.yml?token=AAMLKO5GH2LD6I3PY6XY5KLACRYSK)** to your local **audit-manager.yml** file in Cloud9 and save it. 
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
aws cloudformation delete-stack --stack-name aws-5-mins-auditmanager
```