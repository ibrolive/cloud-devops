import jenkins.model.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.plugins.credentials.impl.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import hudson.plugins.sshslaves.*;

println "--> creating SSH credentials"

domain = Domain.global()
store = Jenkins.instance.getExtensionList('com.cloudbees.plugins.credentials.SystemCredentialsProvider')[0].getStore()

slavesPrivateKey = new BasicSSHUserPrivateKey(
CredentialsScope.GLOBAL,
"jenkins-slaves",
"ec2-user",
new BasicSSHUserPrivateKey.UsersPrivateKeySource(),
"",
""
)

managersPrivateKey = new BasicSSHUserPrivateKey(
CredentialsScope.GLOBAL,
"swarm-managers",
"ec2-user",
new BasicSSHUserPrivateKey.UsersPrivateKeySource(),
"",
""
)

githubCredentials = new UsernamePasswordCredentialsImpl(
  CredentialsScope.GLOBAL,
  "github", "Github credentials",
  "USERNAME",
  "PASSWORD"
)

registryCredentials = new UsernamePasswordCredentialsImpl(
  CredentialsScope.GLOBAL,
  "registry", "Docker Registry credentials",
  "ibrolive",
  "Opepopup0*"
)

awsCredentials = new UsernamePasswordCredentialsImpl(
  CredentialsScope.GLOBAL,
  "aws_cli_credential", "AWS CLI Credentials",
  "AKIA34ZFWKEGAN2OUDAQ",
  "LT6u5SAss2svk0RuCp1Fs8+ffXuFofr0JgYVgzr2"
)

store.addCredentials(domain, slavesPrivateKey)
store.addCredentials(domain, managersPrivateKey)
store.addCredentials(domain, githubCredentials)
store.addCredentials(domain, registryCredentials)
store.addCredentials(domain, awsCredentials)