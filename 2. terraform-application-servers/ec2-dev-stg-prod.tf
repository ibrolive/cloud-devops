provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "devops_demo" {
  tags = {
    Name   = "172.31.0.0/16",
    Author = "user",
    Tool   = "Terraform",
    Environment = "devops-demo"
  }
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.devops_demo.id
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.devops_demo.id
  name   = "default"
}

resource "aws_instance" "dev" {
  ami           = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro" #t3.micro nitro cpu
  count         = "1"

  tags = {
    Name   = "devops_demo_dev",
    Author = "user",
    Tool   = "Terraform",
    Environment = "devops-demo",
    ENV = "dev"
  }
}

resource "aws_instance" "stg" {
  ami           = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro" #t3.micro nitro cpu
  count         = "1"

  tags = {
    Name   = "devops_demo_stg",
    Author = "user",
    Tool   = "Terraform",
    Environment = "devops-demo",
    ENV = "stg"
  }
}

resource "aws_instance" "prod" {
  ami           = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro" #t3.micro nitro cpu
  count         = "1"

  tags = {
    Name   = "devops_demo_prod",
    Author = "user",
    Tool   = "Terraform",
    Environment = "devops-demo",
    ENV = "prod"
  }
}

// resource "aws_lb" "lb" {
//   name               = "lb"
//   internal           = false
//   load_balancer_type = "application"
//   security_groups    = [data.aws_security_group.default.id]
//   // subnets            = merge(data.aws_subnet_ids.az_a.ids, data.aws_subnet_ids.az_b.ids)

//   enable_deletion_protection = false # change to true for production use

// #  access_logs {
// #    bucket  = aws_s3_bucket.lb_logs.bucket
// #    prefix  = "test-lb"
// #    enabled = true
// #  }

//   tags = {
//     Name   = "jenkins_elb",
//     Author = "user",
//     Tool   = "Terraform",
//     Environment = "devops-demo"
//   }
// }

// resource "aws_lb_target_group" "lb_target_group" {
//   port = 80
  
// }

// resource "aws_lb_target_group_attachment" "lb_target_group_attachment_dev" {
//   count            = length(aws_instance.dev)
//   target_group_arn = aws_lb_target_group.lb_target_group.arn
//   target_id        = aws_instance.dev[count.index].id
//   port             = 80
// }

// resource "aws_lb_target_group_attachment" "lb_target_group_attachment_stg" {
//   count            = length(aws_instance.stg)
//   target_group_arn = aws_lb_target_group.lb_target_group.arn
//   target_id        = aws_instance.stg[count.index].id
//   port             = 80
// }

// resource "aws_lb_target_group_attachment" "lb_target_group_attachment_prod" {
//   count            = length(aws_instance.prod)
//   target_group_arn = aws_lb_target_group.lb_target_group.arn
//   target_id        = aws_instance.prod[count.index].id
//   port             = 80
// }