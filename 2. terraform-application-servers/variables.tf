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
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
}

variable "app_port_frontend" {
  description = "Port exposed by the docker image to redirect traffic to"
}

variable "app_port_backend" {
  description = "Port exposed by the docker image to redirect traffic to"
}

variable "app_count" {
  description = "Number of docker containers to run"
}

variable "health_check_path" {
  description = "Context path to check for application health"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
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