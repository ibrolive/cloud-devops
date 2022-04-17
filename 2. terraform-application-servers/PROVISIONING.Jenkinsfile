pipeline { 
    agent any 
    stages {
        stage ('Select Task') {
            steps {
                script {
                    env.action = input message: 'Choose an action below:', ok: 'ok',
                                parameters: [choice(name: 'action', choices: ['plan', 'apply', 'plan-destroy', 'destroy'], description: '')]
                    
                    echo "${env.action}"
                }
            }
        }
        stage ('Init') {
            steps {
                sh '''
                    cd "2. terraform-application-servers"
                    terraform init
                '''
            }
        }
        stage ('Plan') {
            when {
                expression {
                    return env.action == 'plan';
                }
            }
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding',
                credentialsId: 'aws_cli_credential',
                usernameVariable: 'AWS_ACCESS_KEY_ID',
                passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh """
                        export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                        export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                        cd "2. terraform-application-servers"
                        terraform plan -var-file=app.tfvars
                    """
                }
            }
        }
        stage ('Apply') {
            when {
                expression {
                    return env.action == 'apply';
                }
            }
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding',
                credentialsId: 'aws_cli_credential',
                usernameVariable: 'AWS_ACCESS_KEY_ID',
                passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh """
                        export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                        export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                        cd "2. terraform-application-servers"
                        terraform apply --auto-approve -var-file=app.tfvars
                    """
                }
            }
        }
        stage ('Destroy Plan') {
            when {
                expression {
                    return env.action == 'plan-destroy';
                }
            }
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding',
                credentialsId: 'aws_cli_credential',
                usernameVariable: 'AWS_ACCESS_KEY_ID',
                passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh """
                        export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                        export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                        cd "2. terraform-application-servers"
                        terraform plan -destroy -var-file=app.tfvars
                    """
                }
            }
        }
        stage ('Destroy') {
            when {
                expression {
                    return env.action == 'destroy';
                }
            }
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding',
                credentialsId: 'aws_cli_credential',
                usernameVariable: 'AWS_ACCESS_KEY_ID',
                passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    sh """
                        export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                        export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                        cd "2. terraform-application-servers"
                        terraform destroy -auto-approve -var-file=app.tfvars
                    """
                }
            }
        }
    }           
 }