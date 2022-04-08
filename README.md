# cloud-devops

## HOW TO USE
1. Install following pre-requisites:
   - [packer 1.8.0](https://www.packer.io/downloads)
   - [terraform 1.1.8](https://www.terraform.io/downloads)
   - [aws-cli](https://aws.amazon.com/cli/)
2. Verify that the required versions of the pre-requisites are correctly installed using the following commands:
   - `packer -v`
   - `terraform -v`
   - `aws --version`
3. Execute `aws configure` to setup the required AWS Access Key ID, AWS Secret Access Key and default region (us-east-1)
4. Checkout the code from this github repository
5. Execute `Build AMI.bat` (for Windows) or `Build AMI.sh` (for Linux) to provision a base image with Jenkins already installed
6. In [jenkins.tfvars](1.%20terraform-jenkins-server/jenkins.tfvars), you can set the following variables:
   - default region
   - your account `owner` (AWS Account ID) 
   - jenkins login username
   - jenkins login password
   - EC2 instance size for jenkins
5. Execute `Provision-Jenkins.bat` (for Windows) or `Provision-Jenkins.sh` (for Linux) to provision a Jenkins instance. After Jenkins is provisioned successfully, you can login using the jenkins username and password you provided in the above step
6. Add dockerhub login details in Jenkins credential registry
7. Update `dockerhub_repository` on line 1 of [ci-cd/CI-CD.Jenkinsfile](3.%20ci-cd/CI-CD.Jenkinsfile)

## ARCHITECTURE

![Architecture Diagram](assets/infra-architecture.jpeg)

### CI/CD PIPELINE

1. build code base

2. test code base

3. build docker container

4. push docker container

5. deploy application across different environments on target infra (using ansible with ssh)
 
   - deploy to dev environment
   - deploy to staging environment
   - deploy to production environment

### INFRASTRUCTURE PROVISIONING (TERRAFORM)

1. create infrastructure as code for:
   - Jenkins build server (for CI/CD) + Nagios server (for monitoring and auditing)
   - pipeline to provision frontend and backend dev, staging & production EC2 instances on AWS
2. setup access control (to allow multiple personal accounts)

3. add auto scaling to servers (bonus point)

4. mysql/postgresql database (bonus point)
 
5. create destroy functionality


## CLEAN UP / DESTROY
1. Execute `Destroy-Jenkins.bat` or `Destroy-Jenkins.sh` batch file