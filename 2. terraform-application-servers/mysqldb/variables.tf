
variable "aws_region" {
  description = "The AWS region resources are created in"
}

variable "db_name" {
  description = "MySQL database name"
}

variable "db_username" {
  description = "MySQL database username"
}

variable "db_password" {
  description = "MySQL database password"
}

variable "db_port" {
  description = "MySQL database port"
}

variable "db_instance_class" {
  description = "MySQL database instance class"
}