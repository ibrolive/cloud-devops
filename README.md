# cloud-devops

## ASSUMPTIONS
1. I have tested the setup scripts for Windows and assume that this demo will be run on a Windows.
2. This demo was developed using an AWS user with admin permissions (FullAccess) to EC2 and ECS.

## HOW TO USE
1. Install following pre-requisites on your local computer to provision Jenkins on AWS EC2:
   - [packer 1.8.0](https://www.packer.io/downloads)
   - [terraform 1.1.8](https://www.terraform.io/downloads)
   - [aws-cli](https://aws.amazon.com/cli/)
2. Verify that the required versions of the pre-requisites are correctly installed using the following commands:
   - `packer -v`
   - `terraform -v`
   - `aws --version`
3. Open a Command Prompt window and execute `aws configure` to setup the required AWS Access Key ID, AWS Secret Access Key and default region (us-east-1) for the AWS account where the infrastructure will be provisioned. Note that the default region has to be us-east-1 for this demo as the base AMI image used for this demo is located in this region.
4. Checkout the code from this github repository
5. Execute `Build AMI.bat` (for Windows) or `Build AMI.sh` (for Linux) to provision a base AMI image with Jenkins already installed. The AMI build should only take a few minutes. Once AMI is built successfully, you should see a message similar to the screenshot below:
![Building AMI for Jenkins](assets/building-ami-for-jenkins.jpg)
You should also see a [new AMI in us-east-1 region](https://us-east-1.console.aws.amazon.com/ec2/v2/home?region=us-east-1#Images:visibility=owned-by-me) like the screenshot below:
![New AMI built with packer](assets/new-ami-built-with-packer.jpg)
6. In [1. terraform-jenkins-server/jenkins.tfvars](1. terraform-jenkins-server/jenkins.tfvars), you can set the values for the following:
   - default region (must be us-east-1 for this demo)
   - your account `owner` (AWS Account ID) 
   - jenkins login username
   - jenkins login password
   - EC2 instance size for jenkins
5. Execute `Provision-Jenkins.bat` (for Windows) or `Provision-Jenkins.sh` (for Linux) to provision a Jenkins instance. After Jenkins is provisioned successfully, you can login using the jenkins username and password you provided in the above step
6. Add dockerhub login details in Jenkins credential registry
7. Update `dockerhub_repository` on line 1 of [3. ci-cd/CI-CD.Jenkinsfile](https://github.com/ibrolive/cloud-devops/blob/main/3.%20ci-cd/CI_CD.Jenkinsfile)
8. Update your docker hub username and encrypted password credentials in the JCasC config file: [0.AMI/jenkins.yaml](https://github.com/ibrolive/cloud-devops/blob/main/0.AMI/jenkins.yaml)

## ARCHITECTURE

![Architecture Diagram](assets/infra-architecture.jpeg)

### CI/CD PIPELINE

1. build code base

2. test code base

3. build docker container

4. push docker container

5. deploy frontend and backend services to AWS ECS

### INFRASTRUCTURE PROVISIONING (TERRAFORM)

1. create infrastructure as code for:
   - Jenkins build server (for CI/CD) + Nagios server (for monitoring and auditing)
   - pipeline to provision frontend and backend ECs instances on AWS
2. setup access control (to allow multiple personal accounts)

3. add auto scaling to servers (bonus point)

4. mysql/postgresql database (bonus point) [not done]
 
5. create destroy functionality


## CLEAN UP / DESTROY
1. Execute `Destroy-Jenkins.bat` or `Destroy-Jenkins.sh` batch file