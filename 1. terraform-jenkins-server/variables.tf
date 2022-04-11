// Global variables
variable "region"{
  description = "region"
}

variable "shared_credentials_file" {
  default = "/home/user/.aws/credentials"
}

variable "aws_profile" {
  default = "default"
}

variable "jenkins_username" {
  description = "Jenkins username"
}

variable "jenkins_password" {
  description = "Jenkins password"
}

// Default variables

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

// Jenkins Master

variable "custom-jenkins-ami_instance_type" {
  description = "Jenkins Master instance type"
}

