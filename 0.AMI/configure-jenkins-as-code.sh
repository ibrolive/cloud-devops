# copy jcasc configuration to jenkins home directory
cp ./jenkins.yaml /var/lib/jenkins/jenkins.yaml
# add jenkins user to the docker group to allow jenkins to execute docker commands
usermod -a -G docker jenkins