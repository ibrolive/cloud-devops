// Global variables
variable "region"{
  description = "region"
}

variable "owner" {
  description = "owner"
}

// variable "vpc_id" {
//   description = "vpc_id"
// }

// variable "subnet" {
//   description = "subnet"
// }

variable "shared_credentials_file" {
  default = "/home/user/.aws/credentials"
}

variable "aws_profile" {
  default = "default"
}

// variable "jenkins_sg_id" {
//   description = "Jenkins security group ID"
// }

variable "jenkins_username" {
  description = "Jenkins username"
}

variable "jenkins_password" {
  description = "Jenkins password"
}

// variable "jenkins_credentials_id" {
//   description = "Slaves SSH ID"
//   default = "jenkins"
// }

// variable "vpc_id" {
//   default = "vpc-05215a5399646ca1d"
// }

// variable "vpc_private_subnets" {
//   description = "List of VPC private subnets"
//   type        = list
//   default = ["subnet-0c0c2f9dff155fe46"]
// }

// variable "vpc_public_subnets" {
//   description = "List of VPC Public subnets"
//   type        = list
//   default = ["subnet-0c0c2f9dff155fe46"]
// }

// Default variables

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

// variable "key_name" {
//   description = "SSH KeyPair"
//   default = "jong-prod"
// }

// Jenkins Master

variable "custom-jenkins-ami_instance_type" {
  description = "Jenkins Master instance type"
}

