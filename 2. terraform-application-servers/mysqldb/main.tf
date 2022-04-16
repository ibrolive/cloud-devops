provider "aws" {
  region = var.aws_region
}

locals {
  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

################################################################################
# Supporting Resources
################################################################################

data "aws_vpc" "main" {
  default = true
}

data "aws_availability_zones" "available" {
}

data "aws_subnets" "all" {
  
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = var.db_name
  description = "Complete MySQL example security group"
  vpc_id      = data.aws_vpc.main.id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "MySQL access from within VPC"
      cidr_blocks = "0.0.0.0/0" # data.aws_vpc.main.cidr_block
    },
  ]

  tags = local.tags
}

################################################################################
# RDS Module
################################################################################

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.db_name

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0.27"
  family               = "mysql8.0" # DB parameter group
  major_engine_version = "8.0"      # DB option group
  instance_class       = var.db_instance_class
  publicly_accessible  = true // change to false for production workloads

  allocated_storage     = 20
  max_allocated_storage = 21

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password  // use secrets manager or parameter store with randomly generated password for production workloads !!!
  port     = var.db_port

  multi_az               = false
  subnet_ids             = data.aws_subnets.all.ids // switch to dedicated database subnets for production workloads !!!
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["general"]
  create_cloudwatch_log_group     = true

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false
  storage_encrypted       = false // encryption is not supported by db.t2.micro instance class

  performance_insights_enabled          = false // not supported for current configuration. set to true for production workload
  performance_insights_retention_period = 0     // set to 7 or greater than 0 for production workload
  create_monitoring_role                = false // not required for demo. set to true for production workload
  monitoring_interval                   = 0     // set to 60 or greater than 0 for productino workload.

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  tags = local.tags
  db_instance_tags = {
    "Sensitive" = "high"
  }
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }
  db_subnet_group_tags = {
    "Sensitive" = "high"
  }
}

# module "db_default" {
#   source = "terraform-aws-modules/rds/aws"

#   identifier = "${local.name}-default"

#   create_db_option_group    = false
#   create_db_parameter_group = false

#   # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
#   engine               = "mysql"
#   engine_version       = "8.0.27"
#   family               = "mysql8.0" # DB parameter group
#   major_engine_version = "8.0"      # DB option group
#   instance_class       = "db.t2.micro"

#   allocated_storage = 20

#   db_name  = "mysql_db"
#   username = "user1"
#   password = "password"  // use secrets manager or parameter store with randomly generated password for production workloads !!!
#   port     = 3306

#   subnet_ids             = module.vpc.database_subnets
#   vpc_security_group_ids = [module.security_group.security_group_id]

#   maintenance_window = "Mon:00:00-Mon:03:00"
#   backup_window      = "03:00-06:00"

#   backup_retention_period = 0

#   tags = local.tags
# }
