provider "aws" {
  region = var.region
}
data "aws_ami" "custom-jenkins-ami" {
  most_recent = true
  owners      = [var.owner]

  filter {
    name   = "name"
    values = ["custom-jenkins-ami"]
  }
}

output "ami_id" {
  value = "${data.aws_ami.custom-jenkins-ami.id}"
}

output "name" {
  value = "${data.aws_ami.custom-jenkins-ami.name}"
}
