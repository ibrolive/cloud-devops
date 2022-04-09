cd ./1. terraform-jenkins-server
terraform init -input=false
terraform plan -destroy -input=false -var-file=jenkins.tfvars
terraform destroy -auto-approve -input=false -var-file=jenkins.tfvars
pause