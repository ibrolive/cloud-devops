def GIT_BRANCH="dev"
pipelineJob("CICD-Frontend") {
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url("https://github.com/ibrolive/cloud-devops.git")
          }
          branch("${GIT_BRANCH}")
        }
      }
      scriptPath("3. ci-cd/CI_CD_Frontend.Jenkinsfile")
    }
  }
  triggers {
    scm('* * * * *')
  }
}
pipelineJob("CICD-Backend") {
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url("https://github.com/ibrolive/cloud-devops.git")
          }
          branch("${GIT_BRANCH}")
        }
      }
      scriptPath("3. ci-cd/CI_CD_Backend.Jenkinsfile")
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
          branch("${GIT_BRANCH}")
        }
      }
      scriptPath("2. terraform-application-servers/PROVISIONING.Jenkinsfile")
    }
  }
  triggers {
    scm('* * * * *')
  }
}