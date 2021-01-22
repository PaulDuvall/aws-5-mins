# Launch CloudFormation Stack

Create an empty YAML file.

```
cd ~/environment/aws-5-mins
touch audit-manager.yml
```
1. Copy the contents from **[audit-manager.yml](https://raw.githubusercontent.com/PaulDuvall/aws-5-mins/main/audit-manager/audit-manager.yml?token=AAMLKO5GH2LD6I3PY6XY5KLACRYSK)** to your local **audit.yml** file in Cloud9 and save it. 
1. Run the command below to launch a CloudFormation stack that generates an Audit Manager assessment. 

```
aws cloudformation create-stack --stack-name auditmanager --template-body file://audit-manager.yml --capabilities CAPABILITY_IAM
```

It takes less than 1 minute to launch the stack and the Audit Manager assessment begins. You will need to wait up to 24 hours to view collected evidence. You can visit the [Audit Manager](https://console.aws.amazon.com/auditmanager) console to see the assessment configuration.