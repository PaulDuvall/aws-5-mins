# Launch CloudFormation Stack

Create an empty YAML file.

```
mkdir ~/environment/my-aws-5-mins
cd ~/environment/my-aws-5-mins
touch devops-guru.yml
```
1. Copy the contents from **[devops-guru.yml](https://raw.githubusercontent.com/PaulDuvall/aws-5-mins/main/devops-guru/devops-guru.yml?token=AAMLKO5WPMCUJSMPCSCFW4TACR3NM** to your local **devops-guru.yml** file in Cloud9 and save it. 
1. Run the command below to launch a CloudFormation stack. 

```
aws cloudformation create-stack --stack-name devops-guru --template-body file://devops-guru.yml --capabilities CAPABILITY_IAM
```

It takes less than 1 minute to launch the stack. You can visit the [DevOps Guru](https://console.aws.amazon.com/codeguru/devops-guru/) Console.