# AWS Cloud9

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
