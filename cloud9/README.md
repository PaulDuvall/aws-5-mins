# AWS Cloud9

[AWS Cloud9](https://aws.amazon.com/cloud9/) is a cloud-based integrated development environment (IDE) that lets you write, run, and debug your code with just a browser. It has a code editor, debugger, and terminal. Comes with support for popular programming languages, including JavaScript, Python, PHP, and more, so you don’t need to install files or configure your development machine to start new projects. Since it is cloud-based, you can work on your projects from anywhere - your office, home, or anywhere using an internet-connected machine. You can collaborate with others in real time. It has AWS CLI, Git, and several package managers come preinstalled. There’s support for languages like Node.js (JavaScript), Python, PHP, Ruby, Go, and C++ (code completion, syntax checking)

You are charged for compute and storage fees the same way as an EC2 instance (different sizes) because that’s what the IDE is running on. It automatically stops the EC2 instance after it hasn’t been used for a certain period of time (default is 30 mins).

## Launch a Cloud9 Environment
1. Go to the [AWS Cloud9 console](https://console.aws.amazon.com/cloud9/) and select **Create environment**.
1. Enter a **Name** and **Description** (such as `#aws-5-mins`).
1. Select **Next step**.
1. Select **Create a new instance for environment (EC2)**.
1. Select **t2.micro**.
1. Leave the Cost-saving setting at the *After 30-minute (default)*.
1. Select **Next step**.
1. Review best practices and select **Create environment**.
1. Once your Cloud environment has been launched, open a new terminal in Cloud9.

## Configure Cloud9 to Disable Temporary managed credentials
1. From your [Cloud9](https://console.aws.amazon.com/cloud9/) environment, go to Preferences (the gear icon).
1. Scroll and choose **AWS Settings**.
1. Deselect the toggle for **AWS Managed temporary credentials**.
1. Sign in to the [IAM console](https://console.aws.amazon.com/iam).
1. In the navigation bar, choose **Roles**.
1. Choose **Create role**.
1. On the *Select type of trusted entity* page, with AWS service already chosen, for Choose the service that will use this role, choose **EC2**.
1. For Select your use case, choose **EC2**.
1. Choose **Next: Permissions**.
1. On the *Attach permissions policies* page, in the list of policies, select the box next to **AdministratorAccess**, and then choose **Next: Review**.
1. On the *Review* page, for Role Name, *type a name for the role* (for example `aws-5-mins-cloud9-instance-role`).
1. Choose **Create Role**.
1. Sign in to the [Amazon EC2 console](https://console.aws.amazon.com/ec2).
1. In the navigation bar, be sure the region selector displays the AWS Region that matches the one for your environment.
1. Choose the **Running Instances** link or, in the navigation pane, expand **Instances**, and then choose **Instances**.
1. In the list of instances, choose the instance with the Name that includes your environment name.
1. Choose **Actions**, **Security**, **Modify IAM Role**.
1. On the **Modify IAM Role** page, for IAM role, choose the name of the role you identified or that you created in the previous procedure, and then choose **Save**.
