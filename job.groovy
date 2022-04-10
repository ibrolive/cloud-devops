pipelineJob("CICD") {
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url("https://github.com/ibrolive/cloud-devops.git")
          }
        }
      }
      scriptPath("3. ci-cd/CI_CD.Jenkinsfile")
    }
  }
  triggers {
    scm('* * * * *')
  }
}
pipelineJob("PROVISIONING") {
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url("https://github.com/ibrolive/cloud-devops.git")
          }
        }
      }
      scriptPath("2. terraform-application-servers/PROVISIONING.Jenkinsfile")
    }
  }
  triggers {
    scm('* * * * *')
  }
}