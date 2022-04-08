cd 0.AMI/ 
packer build ami.json


cd ../1.\ terraform-jenkins-server
terraform init
terraform plan
terraform apply -auto-approve
pause
