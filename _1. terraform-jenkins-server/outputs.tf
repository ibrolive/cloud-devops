output "Jenkins_URL" {
  value = "http://${aws_instance.custom-jenkins-ami.public_ip}:8080"
}
