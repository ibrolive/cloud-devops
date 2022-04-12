# provider "aws" {
#   region = "us-east-1"
# }

resource "random_number" "this" {
  length = 2
}

module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name     = "manager-${random_number.this.id}"
  hash_key = "id"

  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "name"
      type = "S"
    },
    {
      name = "password"
      type = "S"
    },
    {
      name = "roles"
      type = "S"
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}

module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name      = "employee-${random_number.this.id}"
  hash_key  = "id"
  # range_key = "title"

  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "firstName"
      type = "S"
    },
    {
      name = "lastName"
      type = "S"
    },
    {
      name = "description"
      type = "S"
    },
    {
      name = "version"
      type = "S"
    },
    {
      name = "manager"
      type = "S"
    },
  ]

  # global_secondary_indexes = [
  #   {
  #     name               = "TitleIndex"
  #     hash_key           = "title"
  #     range_key          = "age"
  #     projection_type    = "INCLUDE"
  #     non_key_attributes = ["id"]
  #   }
  # ]

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}