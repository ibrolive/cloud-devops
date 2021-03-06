# variables.tf

variable "aws_region" {
  description = "The AWS region resources are created in"
  default     = "us-east-1"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default = "myEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "nginxdemos/hello" # ibrolive/devops-demo:react-springboot-image-frontend
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 3
}

variable "health_check_path" {
  default = "/login"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
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