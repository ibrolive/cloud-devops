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
}