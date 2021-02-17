**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS CloudShell. CloudShell is a fully-managed service that provides you command line access to AWS resources and tools directly from a browser.

It comes preinstalled with the AWS CLI, SAM CLI, Node.js, Git, vim, Powershell, and Python. It run on an Amazon Linux 2 Environment and is always up to date with the latest patches. You don't have to worry about patching the environment. Made some configuration errors. Don't have to keep the packages up to date. 

CloudShell is always available from the console through an one-click icon at the top of every console page. 

There are no extra credentials you need to manage at it uses the credentials of the logged in user to the console.

Your CloudShell environment is terminated after 20 minutes of inactivity but you can keep using it for 12 hour continuously.

Only your home directory is persisted and you can store 1GB in this directory.

Your CloudShell environment is launched into a dedicated VPC managed by AWS. As of now, you can have outbound connections but not inbound connections. 

Launching into an existing VPC in on near-term roadmap.

Very useful for experimentation. 


Helpful for context - switching between AWS accounts.

. bashrc






 Reduce need for bastion host?

Ensuring consistency because of the ephemeral nature of CloudShell.

Dark and Light Mode, Modify Font Size.

Download and Upload Files.

Multiple tabs, columns.

CloudShell is free. Up to 10 sessions per region (soft limit). Pay for outbound traffic. 

Launched in 5 regions but more to come. 



# Pricing
There is no extra cost. You only pay for the resources you use or create from CloudShell. 

# Additional Resources

* [AWS Podcast #416: Introducing AWS CloudShell](https://aws.amazon.com/podcasts/416-introducing-aws-cloudshell/)
* [AWS CloudShell – Command-Line Access to AWS Resources](https://aws.amazon.com/blogs/aws/aws-cloudshell-command-line-access-to-aws-resources/)
