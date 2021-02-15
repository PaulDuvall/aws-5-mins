**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS CloudShell.

Very useful for experimentation. 

Comes with the AWS CLI, SAM CLI, Node.js, Python preinstalled.

Helpful for context - switching between AWS accounts.

Uses credentials of the logged in user to the console.

Always available from the console.

Git, vim, Powershell. Amazon Linux 2 Environment.

Only your home directory is persisted.

. bashrc

1GB storage for home directory.

CloudShell env is terminated after 20 minutes of inactivity but you can keep using it for 12 hour continuously.

Don't have to worry about patching the environment. Made some configuration errors. Don't have to keep the packages up to date. 

Launched in a dedicated VPC. As of now, you can have outbound connections but not inbound connections. 

Launching into an existing VPC in on near-term roadmap. Reduce need for bastion host?

No additional charge for CloudShell.

Ensuring consistency because of the ephemeral nature of CloudShell.

Dark and Light Mode, Modify Font Size.

Download and Upload Files.

# CloudFormation Support
TBD


## Launch CloudFormation Stack

TBD


# Deployment Pipeline

# Pricing
TBD

# Delete Resources

```
aws cloudformation delete-stack --stack-name aws-5-mins-SERVICENAME
```


# Additional Resources

* [AWS Podcast #416: Introducing AWS CloudShell](https://aws.amazon.com/podcasts/416-introducing-aws-cloudshell/)
* [AWS CloudShell – Command-Line Access to AWS Resources](https://aws.amazon.com/blogs/aws/aws-cloudshell-command-line-access-to-aws-resources/)
