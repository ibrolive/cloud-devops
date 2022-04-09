# Security Group:
resource "aws_security_group" "custom-jenkins-ami_sg" {
  name        = "custom-jenkins-ami_sg"
  description = "Jenkins Server: created by Terraform for [dev]"

  # legacy name of VPC ID
  vpc_id = "${module.vpc.vpc_id}"

  tags = {
    Name = "custom-jenkins-ami",
    env  = "dev",
    Environment = "devops-demo"
  }
}

###############################################################################
# ALL INBOUND
###############################################################################

# ssh
resource "aws_security_group_rule" "custom-jenkins-ami_from_source_ingress_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.custom-jenkins-ami_sg.id}"
  cidr_blocks       = ["0.0.0.0/0", "172.31.0.0/16"]
  description       = "ssh to custom-jenkins-ami_sg"
}

# jenkins
resource "aws_security_group_rule" "custom-jenkins-ami_from_source_ingress_webui" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = "${aws_security_group.custom-jenkins-ami_sg.id}"
  cidr_blocks       = ["0.0.0.0/0", "172.31.0.0/16"]
  description       = "jenkins"
}

# smtp
resource "aws_security_group_rule" "custom-jenkins-ami_from_source_ingress_smtp" {
  type              = "ingress"
  from_port         = 25
  to_port           = 25
  protocol          = "tcp"
  security_group_id = "${aws_security_group.custom-jenkins-ami_sg.id}"
  cidr_blocks       = ["0.0.0.0/0", "172.31.0.0/16"]
  description       = "smtp"
}



###############################################################################
# ALL OUTBOUND
###############################################################################

resource "aws_security_group_rule" "custom-jenkins-ami_to_other_machines_ssh" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.custom-jenkins-ami_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "allow jenkins master to ssh to other machines"
}

resource "aws_security_group" "elb_jenkins_sg" {
  name        = "elb_jenkins_sg"
  description = "Allow https traffic"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "elb_jenkins_sg",
    Author = "user",
    Tool   = "Terraform",
    Environment = "devops-demo"
  }
}
