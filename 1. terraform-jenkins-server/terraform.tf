// terraform {
//   backend "s3" {
//     encrypt = "true"
//     bucket  = "terraform-user"
//     region  = "us-east-1"
//     key     = "jenkins/terraform.tfstate"
//   }
// }

// provider "aws" {
//   region                  = "us-east-1"
//   shared_credentials_file = "/home/user/.aws/credentials"
//   profile                 = "default"
// }
