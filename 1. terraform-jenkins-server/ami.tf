provider "aws" {
  region = var.region
}
data "aws_ami" "custom-jenkins-ami" {
  most_recent = true
  owners      = [data.aws_caller_identity.current.account_id]

  filter {
    name   = "name"
    values = ["custom-jenkins-ami"]
  }
}
data "aws_caller_identity" "current" {}

output "ami_id" {
  value = "${data.aws_ami.custom-jenkins-ami.id}"
}

output "name" {
  value = "${data.aws_ami.custom-jenkins-ami.name}"
}
