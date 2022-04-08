resource "aws_instance" "custom-jenkins-ami" {
  ami                    = "${data.aws_ami.custom-jenkins-ami.id}"
  instance_type          = "${var.custom-jenkins-ami_instance_type}"
  key_name               = "${aws_key_pair.keypair.key_name}"
  vpc_security_group_ids = ["${aws_security_group.custom-jenkins-ami_sg.id}"]
  subnet_id              = "${module.vpc.public_subnets[0]}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = false
  }

  tags = {
    Name   = "custom-jenkins-ami",
    Author = "user",
    Tool   = "Terraform",
    Environment = "devops-demo"
  }
}

##############
# EC2 KEY PAIR
##############
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "keypair" {
  key_name = "devops-demo"
  public_key      = tls_private_key.this.public_key_openssh

  tags = {
    Name   = "custom-jenkins-ami",
    Author = "user",
    Tool   = "Terraform",
    Environment = "devops-demo"
  }
}

######################
# SSM Secret Parameter
######################

resource "aws_ssm_parameter" "keypair" {
  name        = "devops-demo"
  description = "Instances Key Pair credentials"
  type        = "SecureString"
  value       = tls_private_key.this.private_key_pem

  tags = {
    Name   = "custom-jenkins-ami",
    Author = "user",
    Tool   = "Terraform",
    Environment = "devops-demo"
  }
}