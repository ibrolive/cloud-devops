cd ./1. terraform-jenkins-server
terraform init -input=false
terraform plan -out=tfplan -input=false -var-file=jenkins.tfvars
terraform apply --auto-approve -input=false tfplan
pause