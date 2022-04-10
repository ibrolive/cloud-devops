# provider.tf

# Specify the provider and access details
provider "aws" {
  #shared_credentials_files = ["$HOME/.aws/credentials"] # using jenkins credential variable instead
  profile                 = "default"
  region                  = var.aws_region
}

