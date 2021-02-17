**NOTE: This video has not been released yet.**

You can find the 5-minute video that walks through all of the steps described here. 

In this episode, we'll be looking at AWS CloudShell. CloudShell is a fully-managed service that provides you command line access to AWS resources and tools directly from a browser. 

![How it Works](https://github.com/PaulDuvall/aws-5-mins/blob/main/_img/cloudshell-howitworks.png)

It comes preinstalled with tools such as the AWS CLI, the SAM CLI, Node.js, Git, vim, Powershell, and Python. It run on an Amazon Linux 2 environment and is always up to date with the latest patches. 

CloudShell is always available from the console through an one-click icon at the top of every console page. 

There are no extra credentials you need to manage at it uses the credentials of the logged in user to the console.

Your CloudShell environment is terminated after 20 minutes of inactivity but you can keep using it for 12 hour continuously. Only your home directory is persisted and you can store 1GB in this directory.

Your CloudShell environment is launched into a dedicated VPC managed by AWS. As of now, you can have outbound connections but not inbound connections. On AWS' near-term roadmap is launching into an existing VPC.
 
You can customize your shell environment with dark and light mode and by modifying your font size. You can download and upload files and launch multiple tabs and columns.

Because of the ephemeral nature of CloudShell, it can be used to ensure consistency because - other than your home directory - it resets its configuration every time you use it. Therefore, it can be very useful for experimentation. CloudShell is also helpful for establishing context as you switch between AWS accounts as it's easy to determine which account and in which region you are running.

As of February 2020, it has been launched in five AWS regions with more to come.

# Pricing
There is no extra cost. You only pay for the resources you use or create from CloudShell. You can run up to 10 sessions per region - which is a soft limit.

# Demo

## Preferences

1. Select the **Gear icon** on the right-hand side of your CloudShell environment.
1. Choose a different **Font size**.
1. Choose a different **AWS CloudShell theme**.

## Actions
TBD

### Open tabs, rows, and columns


1. Go to **Actions** and select **New Tab**.
1. Go to **Actions** and select **Split into rows**.
1. Go to **Actions** and select **Split into columns**.

### Download File

1. From your CloudShell environment, create a new file.
1. Make some changes to the file.
1. Go to **Actions** and select **Download File**.

### Upload File

1. On your local computer, create a new file.
1. Make some changes to the file.
1. Go to **Actions** and select **Upload File**.

### Restart AWS CloudShell

1. Run the following commands from your CloudShell environment:

```
cd ~
mkdir rs-dir1 rs-dir2 rs-dir3
sudo yum -y install mt-st
sudo yum list installed | grep mt-st
ls
```

1. Go to **Actions** and select **Restart AWS CloudShell**. It will automatically restart your CloudShell environment. Once it's available again, type the following commands: 

```
cd ~
sudo yum list installed | grep mt-st
ls
```

You should see the directories you created along with any of the files in your home directory. 


### Delete AWS CloudShell home directory

1. Run the following commands from your CloudShell environment.

```
cd ~
mkdir del-dir1 del-dir2 del-dir3
ls
```

1. Go to **Actions** and select **Delete AWS CloudShell home directory**. It will automatically restart your CloudShell environment. Once it's available again, type the following commands: 

```
cd ~
ls
```

You should no longer see the directories or any of the files you created in your home directory. 

## Run Commands

1. Run the following commands from your CloudShell environment:

```
pwd
ls
aws
git
node --version
python --version
pwsh
sam
```

# Additional Resources

* [AWS Podcast #416: Introducing AWS CloudShell](https://aws.amazon.com/podcasts/416-introducing-aws-cloudshell/)
* [AWS CloudShell – Command-Line Access to AWS Resources](https://aws.amazon.com/blogs/aws/aws-cloudshell-command-line-access-to-aws-resources/)
