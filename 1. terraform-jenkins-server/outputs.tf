output "Jenkins_URL" {
  value = "http://${aws_instance.custom-jenkins-ami.public_ip}:8080"
}
# output "ELB_DNS_URL" {
#   value = "http://${aws_elb.jenkins_elb.dns_name}"
# }