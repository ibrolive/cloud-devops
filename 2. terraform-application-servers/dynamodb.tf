# provider "aws" {
#   region = "us-east-1"
# }

resource "random_pet" "this" {
  length = 2
}

module "dynamodb_table_manager" {
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name     = "manager-${random_pet.this.id}"
  hash_key = "id"

  attributes = [
    {
      name = "id"
      type = "N"
    },
    # {
    #   name = "name"
    #   type = "S"
    # },
    # {
    #   name = "password"
    #   type = "S"
    # },
    # {
    #   name = "roles"
    #   type = "S"
    # },
  ]

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}

module "dynamodb_table_employee" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name      = "employee-${random_pet.this.id}"
  hash_key  = "id"

  attributes = [
    {
      name = "id"
      type = "N"
    },
    # {
    #   name = "firstName"
    #   type = "S"
    # },
    # {
    #   name = "lastName"
    #   type = "S"
    # },
    # {
    #   name = "description"
    #   type = "S"
    # },
    # {
    #   name = "version"
    #   type = "S"
    # },
    # {
    #   name = "manager"
    #   type = "S"
    # },
  ]

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}